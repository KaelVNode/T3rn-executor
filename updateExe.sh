#!/bin/bash

# Menghapus file updateExe.sh dan file lain yang memiliki nama serupa (updateExe.sh.1, updateExe.sh.2, dst.)
echo "Menghapus file updateExe.sh dan file terkait..."
rm -f updateExe.sh updateExe.sh.[0-9]*
if [ $? -ne 0 ]; then
  echo "Gagal menghapus file updateExe.sh atau file terkait."
  exit 1
fi

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
  echo "3) Setting Gas Fee"
  echo "4) Ga Tau"
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
      
      # Proses update node seperti yang sebelumnya
      # ... (lanjutkan dengan sisa kode Anda)
      continue
      ;;
    2)
      echo "Menampilkan logs t3rn-executor..."
      sudo journalctl -u t3rn-executor.service -f --no-hostname -o cat
      continue
      ;;
    3)
      echo "Setting Gas Fee"
      # ... (lanjutkan dengan kode setting gas fee)
      continue
      ;;
    4)
      echo "Exit Script."
      exit 0
      ;;
    *)
      echo "Pilihan tidak valid! Kembali ke menu..."
      continue
      ;;
  esac

done

# Pesan terakhir sebelum skrip selesai
echo "Dah ya, mo tidur"
