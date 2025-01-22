#!/bin/bash

# Menampilkan ASCII Art untuk "Saandy"
echo "
  ██████ ▄▄▄     ▄▄▄      ███▄    █▓█████▓██   ██▓
▒██    ▒▒████▄  ▒████▄    ██ ▀█   █▒██▀ ██▒██  ██▒
░ ▓██▄  ▒██  ▀█▄▒██  ▀█▄ ▓██  ▀█ ██░██   █▌▒██ ██░
  ▒   ██░██▄▄▄▄█░██▄▄▄▄██▓██▒  ▐▌██░▓█▄   ▌░ ▐██▓░
▒██████▒▒▓█   ▓██▓█   ▓██▒██░   ▓██░▒████▓ ░ ██▒▓░
▒ ▒▓▒ ▒ ░▒▒   ▓▒█▒▒   ▓▒█░ ▒░   ▒ ▒ ▒▒▓  ▒  ██▒▒▒ 
░ ░▒  ░ ░ ▒   ▒▒ ░▒   ▒▒ ░ ░░   ░ ▒░░ ▒  ▒▓██ ░▒░ 
░  ░  ░   ░   ▒   ░   ▒     ░   ░ ░ ░ ░  ░▒ ▒ ░░  
      ░       ░  ░    ░  ░        ░   ░   ░ ░     
                                    ░     ░ ░     
"

function update_node() {
  echo -n "Masukkan versi executor yang ingin diunduh (contoh: 0.42.0): "
  read VERSION

  if [ -z "$VERSION" ]; then
    echo "Versi tidak boleh kosong!"
    exit 1
  fi

  EXECUTOR_URL="https://github.com/t3rn/executor-release/releases/download/v${VERSION}/executor-linux-v${VERSION}.tar.gz"
  EXECUTOR_FILE="executor-linux-v${VERSION}.tar.gz"

  echo "Menghentikan layanan t3rn-executor sebelumnya (jika ada)..."
  sudo systemctl stop t3rn-executor.service || echo "Layanan t3rn-executor tidak berjalan."

  echo "Menghapus folder executor lama..."
  rm -rf executor || { echo "Gagal menghapus folder executor"; exit 1; }

  echo "Mengunduh versi ${VERSION} dari executor..."
  curl -L -o "$EXECUTOR_FILE" "$EXECUTOR_URL"
  if [ ! -f "$EXECUTOR_FILE" ]; then
    echo "File ${EXECUTOR_FILE} tidak ditemukan!"
    exit 1
  fi

  echo "Mengekstrak file executor..."
  tar -xzvf "$EXECUTOR_FILE" || { echo "Gagal mengekstrak file"; exit 1; }
  rm -f "$EXECUTOR_FILE"

  echo "Menyiapkan direktori bin..."
  cd executor/executor/bin || { echo "Direktori bin tidak ditemukan"; exit 1; }

  echo "Mengaktifkan dan memulai ulang layanan t3rn-executor..."
  sudo systemctl daemon-reload
  sudo systemctl enable t3rn-executor.service
  sudo systemctl restart t3rn-executor.service

  echo "Proses selesai! Layanan t3rn-executor versi ${VERSION} telah diperbarui dan dijalankan."
}

function check_logs() {
  echo "Menampilkan log layanan t3rn-executor..."
  sudo journalctl -u t3rn-executor.service -f --no-hostname -o cat
}

# Menu utama
while true; do
  echo ""
  echo "Pilih opsi:"
  echo "1. Update Node"
  echo "2. Cek Logs Layanan"
  echo "3. Keluar"
  echo -n "Masukkan pilihan Anda (1/2/3): "
  read CHOICE

  case $CHOICE in
    1)
      update_node
      ;;
    2)
      check_logs
      ;;
    3)
      echo "Keluar dari skrip. Sampai jumpa!"
      exit 0
      ;;
    *)
      echo "Pilihan tidak valid! Silakan coba lagi."
      ;;
  esac
done
