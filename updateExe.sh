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

# Fungsi untuk menampilkan menu pilihan
function show_menu() {
  echo "Mau ngapain bang?"
  echo "1) Update Node Bang"
  echo "2) Cek Logs Executor"
  echo "3) Ga Tau"
}

# Menanyakan pilihan dari pengguna
while true; do
  show_menu

  # Membaca input pilihan pengguna
  read pilihan

  # Mengeksekusi sesuai pilihan pengguna
  case $pilihan in
    1)
      echo "Melanjutkan update node..."

      # Menghentikan layanan t3rn-executor sebelumnya (jika ada)
      sudo systemctl stop t3rn-executor.service
      if [ $? -ne 0 ]; then
        echo "Gagal menghentikan layanan t3rn-executor"
        exit 1
      fi

      # Menghapus folder executor lama (pastikan sudah benar-benar selesai)
      rm -rf executor
      if [ $? -ne 0 ]; then
        echo "Gagal menghapus folder executor"
        exit 1
      fi

      # Menghapus skrip updateExe.sh
      rm -rf updateExe.sh
      if [ $? -ne 0 ]; then
        echo "Gagal menghapus skrip updateExe.sh"
        exit 1
      fi

      # Mengunduh versi terbaru dari executor dan mengekstraknya
      curl -L -o executor-linux-v0.31.0.tar.gz https://github.com/t3rn/executor-release/releases/download/v0.31.0/executor-linux-v0.31.0.tar.gz
      if [ $? -ne 0 ]; then
        echo "Gagal mengunduh file executor"
        exit 1
      fi

      tar -xzvf executor-linux-v0.31.0.tar.gz
      if [ $? -ne 0 ]; then
        echo "Gagal mengekstrak file"
        exit 1
      fi
      rm -f executor-linux-v0.31.0.tar.gz

      # Masuk ke direktori bin untuk menyiapkan eksekutor
      cd executor/executor/bin

      # Mengaktifkan dan memulai layanan t3rn-executor
      sudo systemctl daemon-reload
      sudo systemctl enable t3rn-executor.service
      sudo systemctl start t3rn-executor.service
      if [ $? -ne 0 ]; then
        echo "Gagal memulai layanan t3rn-executor"
        exit 1
      fi

      # Setelah update selesai, kembali ke menu pilihan
      echo "Update selesai!"
      continue
      ;;
    2)
      echo "Menampilkan logs t3rn-executor..."
      
      # Menampilkan log dengan journalctl
      sudo journalctl -u t3rn-executor.service -f --no-hostname -o cat
      if [ $? -ne 0 ]; then
        echo "Gagal menampilkan log"
        exit 1
      fi
      ;;
    3)
      echo "Exit Script."
      exit 0  # Keluar dari skrip jika memilih opsi 3
      ;;
    *)
      echo "Pilihan tidak valid!"
      exit 1  # Keluar dengan status 1 jika pilihan tidak valid
      ;;
  esac
done

# Pesan terakhir sebelum skrip selesai
echo "Dah ya, mo tidur"
