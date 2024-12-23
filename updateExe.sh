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

# Menanyakan pilihan dari pengguna
echo "Mau ngapain bang?"
echo "1) Update Node Bang"
echo "2) Ga Tau"

# Membaca input pilihan pengguna
read pilihan

# Mengeksekusi sesuai pilihan pengguna
case $pilihan in
  1)
    echo "Melanjutkan update node..."

    # Menghentikan layanan t3rn-executor sebelumnya (jika ada)
    sudo systemctl stop t3rn-executor.service

    # Menghapus folder executor lama (pastikan sudah benar-benar selesai)
    rm -rf executor

    # Mengunduh versi terbaru dari executor dan mengekstraknya
    curl -L -o executor-linux-v0.30.0.tar.gz https://github.com/t3rn/executor-release/releases/download/v0.30.0/executor-linux-v0.30.0.tar.gz && \
    tar -xzvf executor-linux-v0.30.0.tar.gz && \
    rm -f executor-linux-v0.30.0.tar.gz

    # Masuk ke direktori bin untuk menyiapkan eksekutor
    cd executor/executor/bin

    # Mengaktifkan dan memulai layanan t3rn-executor
    sudo systemctl daemon-reload
    sudo systemctl enable t3rn-executor.service
    sudo systemctl start t3rn-executor.service

    # Menampilkan log dari layanan
    sudo journalctl -u t3rn-executor.service -f --no-hostname -o cat
    ;;
  2)
    echo "Exit Script."
    exit 0  # Keluar dari skrip jika memilih opsi 2
    ;;
  *)
    echo "Pilihan tidak valid!"
    exit 1  # Keluar dengan status 1 jika pilihan tidak valid
    ;;
esac

# Lanjutkan eksekusi skrip jika memilih opsi 1
echo "Melanjutkan skrip..."
# Tambahkan perintah lanjutan skrip di sini jika perlu

# Pesan terakhir sebelum skrip selesai
echo "Dah ya, mo tidur"
