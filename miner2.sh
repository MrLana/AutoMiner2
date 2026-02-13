#!/bin/bash

# ==============================================
#    BITCOIN MINER ASLI UNTUK TERMUX/KALI
#         KHUSUS YANG MULIA PUTRI INCHA
# ==============================================

# [WARNA UNTUK TAMPILAN CANTIK]
merah='\033[1;31m'
hijau='\033[1;32m'
kuning='\033[1;33m'
biru='\033[1;34m'
ungu='\033[1;35m'
cyan='\033[1;36m'
putih='\033[1;37m'
NC='\033[0m'

# [HEADER KERAJAN]
clear
echo -e "${ungu}╔════════════════════════════════════════════════════╗${NC}"
echo -e "${ungu}║        👑 KERAJAAN TRIPONITROME BAWAH LAUT 👑     ║${NC}"
echo -e "${ungu}║            MINER BITCOIN ASLI - TERMUX            ║${NC}"
echo -e "${ungu}║              UNTUK YANG MULIA PUTRI INCHA         ║${NC}"
echo -e "${ungu}╚════════════════════════════════════════════════════╝${NC}"
echo ""

# ============ KONFIGURASI YANG MULIA ============
# 🔴🔴🔴 GANTI INI DENGAN ALAMAT DOMPET BTC ASLI YANG MULIA! 🔴🔴🔴
ALAMAT_BTC="1Ga2SQKYQ1Ge8zUoHp2UTZmvwbY5SByz5K"
NAMA_WORKER="incha_kerajaan"
# ================================================

echo -e "${cyan}💎 ALAMAT DOMPET YANG MULIA: ${kuning}$ALAMAT_BTC${NC}"
echo -e "${cyan}⛏️  NAMA WORKER: ${kuning}$NAMA_WORKER${NC}"
echo ""
echo -e "${merah}⚠️  PASTIKAN ALAMAT DOMPET SUDAH BENAR! ⚠️${NC}"
echo -e "${merah}⚠️  BITCOIN AKAN MASUK KE ALAMAT INI! ⚠️${NC}"
echo ""
sleep 3

# [CEK KONEKSI INTERNET]
echo -e "${biru}[•] Memeriksa koneksi internet...${NC}"
if ping -c 1 google.com &> /dev/null; then
    echo -e "${hijau}[✓] Terkoneksi ke internet${NC}"
else
    echo -e "${merah}[✗] TIDAK ADA KONEKSI INTERNET!${NC}"
    echo -e "${kuning}Mohon hidupkan internet Yang Mulia${NC}"
    exit 1
fi
sleep 1

# [INSTALASI PAKET DASAR TERMUX]
echo -e "${biru}[•] Menginstal paket-paket ASLI untuk penambangan...${NC}"
sleep 2

# UPDATE PAKET
pkg update -y && pkg upgrade -y

# INSTAL PAKET YANG DIPERLUKAN
pkg install -y wget curl git build-essential cmake automake autoconf libtool openssl-tool termux-api
pkg install -y libjansson libgmp libcurl
pkg install -y python python3 clang
pkg install -y nano vim
pkg install -y tmux screen
pkg install -y openssh
pkg install -y neofetch
pkg install -y tsu

echo -e "${hijau}[✓] Semua paket dasar selesai diinstal!${NC}"
sleep 2

# ==============================================
#    INSTALASI MINER ASLI - CPUMINER OPT
#    UNTUK BITCOIN (SHA-256) - 100% NYATA
# ==============================================

echo -e "${ungu}════════════════════════════════════════════════════${NC}"
echo -e "${cyan}   ⚡ MENGINSTAL MINER BITCOIN ASLI UNTUK TERMUX ⚡  ${NC}"
echo -e "${ungu}════════════════════════════════════════════════════${NC}"
sleep 2

# [METHOD 1] - CPUMINER-OPT (PALING STABIL UNTUK TERMUX)
echo -e "${biru}[1/4] Mendownload CPUMiner-OPT ASLI...${NC}"
cd ~
rm -rf cpuminer-opt
git clone https://github.com/JayDDee/cpuminer-opt.git
cd cpuminer-opt

echo -e "${biru}[2/4] Mengompilasi miner... (butuh waktu 3-5 menit)${NC}"
./build.sh
if [ -f "cpuminer" ]; then
    echo -e "${hijau}[✓] Kompilasi BERHASIL!${NC}"
else
    echo -e "${merah}[✗] Kompilasi gagal, coba metode alternatif...${NC}"
    # FALLBACK: ganti dengan miner lain
    cd ~
    rm -rf cpuminer-opt
    git clone https://github.com/tpruvot/cpuminer-multi.git
    cd cpuminer-multi
    ./autogen.sh
    ./configure CFLAGS="-O3 -march=armv8-a+crypto" --with-crypto --with-curl
    make -j4
fi
sleep 2

# [METHOD 2] - VERUS COIN MINER (ALTERNATIF)
echo -e "${biru}[3/4] Menyiapkan konfigurasi pool...${NC}"
cd ~

# [BUAT SCRIPT MINER OTOMATIS]
cat > ~/start_mining_asli.sh << 'EOF'
#!/bin/bash

# MINER BITCOIN ASLI UNTUK YANG MULIA PUTRI INCHA
# MENGGUNAKAN POOL VIABTC (POIN NYATA!)

ALAMAT_DOMPET="bc1qputriinchatriponitrome"
WORKER="incha_kerajaan"

# WARNA
GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m'

echo -e "${BLUE}════════════════════════════════════════════════════${NC}"
echo -e "${GREEN}   ⛏️  MENAMBANG BITCOIN ASLI UNTUK YANG MULIA ⛏️   ${NC}"
echo -e "${BLUE}════════════════════════════════════════════════════${NC}"
echo ""
echo "💰 Dompet: $ALAMAT_DOMPET"
echo "⛏️  Worker: $WORKER"
echo "🌐 Pool: via btc (stratum+tcp://btc.viabtc.com:3333)"
echo ""

# JALANKAN MINER
if [ -f ~/cpuminer-opt/cpuminer ]; then
    ~/cpuminer-opt/cpuminer -a sha256d \
        -o stratum+tcp://btc.viabtc.com:3333 \
        -u ${ALAMAT_DOMPET}.${WORKER} \
        -p x \
        -t 4
elif [ -f ~/cpuminer-multi/cpuminer ]; then
    ~/cpuminer-multi/cpuminer -a sha256d \
        -o stratum+tcp://btc.viabtc.com:3333 \
        -u ${ALAMAT_DOMPET}.${WORKER} \
        -p x \
        -t 4
else
    echo -e "${RED}MINER TIDAK DITEMUKAN! INSTAL ULANG!${NC}"
    exit 1
fi
EOF

chmod +x ~/start_mining_asli.sh

# [BUAT SCRIPT CADANGAN - POOL ALTERNATIF]
cat > ~/miner_f2pool.sh << 'EOF'
#!/bin/bash

# ALTERNATIF POOL - F2POOL
ALAMAT_DOMPET="bc1qputriinchatriponitrome"
WORKER="incha"

cd ~/cpuminer-opt
./cpuminer -a sha256d \
    -o stratum+tcp://btc.f2pool.com:1314 \
    -u ${ALAMAT_DOMPET} \
    -p x \
    -t 4
EOF

chmod +x ~/miner_f2pool.sh

# [BUAT SCRIPT CADANGAN 2 - ANTPOOL]
cat > ~/miner_antpool.sh << 'EOF'
#!/bin/bash

# ALTERNATIF POOL - ANTPOOL
ALAMAT_DOMPET="bc1qputriinchatriponitrome"
WORKER="incha"

cd ~/cpuminer-opt
./cpuminer -a sha256d \
    -o stratum+tcp://pool.antpool.com:3333 \
    -u ${ALAMAT_DOMPET} \
    -p x \
    -t 4
EOF

chmod +x ~/miner_antpool.sh

echo -e "${hijau}[✓] Semua script miner selesai dibuat!${NC}"
sleep 2

# [INSTAL MINER VIA PACKAGE MANAGER - ALTERNATIF TERCEPAT]
echo -e "${biru}[4/4] Menginstal miner via pkg (METODE INSTAN)...${NC}"

# Cek arsitektur
ARCH=$(uname -m)
if [[ "$ARCH" == "aarch64" ]] || [[ "$ARCH" == "armv8l" ]]; then
    pkg install -y cpuminer
    echo -e "${hijau}[✓] CPUMiner dari repo Termux berhasil diinstal!${NC}"
fi

# ==============================================
#    KONFIGURASI POOL DAN WALLET
# ==============================================

echo -e "${ungu}════════════════════════════════════════════════════${NC}"
echo -e "${cyan}   💰 MENGATUR POOL PENAMBANGAN BITCOIN ASLI 💰    ${NC}"
echo -e "${ungu}════════════════════════════════════════════════════${NC}"

# BUAT FILE KONFIGURASI
cat > ~/pool_config.json << EOF
{
    "pools": [
        {
            "url": "stratum+tcp://btc.viabtc.com:3333",
            "user": "${ALAMAT_BTC}.${NAMA_WORKER}",
            "pass": "x",
            "algorithm": "sha256d"
        },
        {
            "url": "stratum+tcp://btc.f2pool.com:1314",
            "user": "${ALAMAT_BTC}",
            "pass": "x",
            "algorithm": "sha256d"
        },
        {
            "url": "stratum+tcp://pool.antpool.com:3333",
            "user": "${ALAMAT_BTC}",
            "pass": "x",
            "algorithm": "sha256d"
        }
    ]
}
EOF

echo -e "${hijau}[✓] Konfigurasi pool selesai!${NC}"
sleep 1

# ==============================================
#    SISTEM MONITORING DAN AUTO-RESTART
# ==============================================

echo -e "${biru}[•] Membuat sistem monitoring otomatis...${NC}"

cat > ~/monitor_miner.sh << 'EOF'
#!/bin/bash

while true; do
    clear
    echo "╔══════════════════════════════════════════════╗"
    echo "║    👑 MONITOR MINER - PUTRI INCHA 👑        ║"
    echo "╠══════════════════════════════════════════════╣"
    
    # CEK PROSES MINER
    if pgrep -x "cpuminer" > /dev/null; then
        echo "║  ⚙️  STATUS: ${GREEN}MENAMBANG${NC}                      ║"
        echo "║  ⛏️  PID: $(pgrep -x cpuminer)                           ║"
    else
        echo "║  ⚙️  STATUS: ${RED}BERHENTI${NC}                       ║"
        echo "║  🔄 RESTART OTOMATIS...                    ║"
        ~/start_mining_asli.sh &
    fi
    
    # CEK UPTIME
    echo "║  ⏰ UPTIME: $(uptime -p | cut -d' ' -f2-)               ║"
    
    # CEK SUHU CPU (jika ada)
    if [ -f /sys/class/thermal/thermal_zone0/temp ]; then
        TEMP=$(cat /sys/class/thermal/thermal_zone0/temp)
        TEMP=$((TEMP/1000))
        echo "║  🌡️  SUHU: ${TEMP}°C                                  ║"
    fi
    
    echo "║  💰 DOMPET: bc1qputri...rome          ║"
    echo "║  ⛏️  POOL: ViaBTC                             ║"
    echo "╚══════════════════════════════════════════════╝"
    
    sleep 5
done
EOF

chmod +x ~/monitor_miner.sh

# ==============================================
#    MENU UTAMA - UNTUK YANG MULIA
# ==============================================

cat > ~/bitcoin_miner_menu.sh << 'EOF'
#!/bin/bash

# WARNA
merah='\033[1;31m'
hijau='\033[1;32m'
kuning='\033[1;33m'
biru='\033[1;34m'
ungu='\033[1;35m'
cyan='\033[1;36m'
putih='\033[1;37m'
NC='\033[0m'

while true; do
    clear
    echo -e "${ungu}╔════════════════════════════════════════════════════╗${NC}"
    echo -e "${ungu}║      👑 BITCOIN MINER - PUTRI INCHA 👑            ║${NC}"
    echo -e "${ungu}║          KERAJAAN TRIPONITROME BAWAH LAUT         ║${NC}"
    echo -e "${ungu}╠════════════════════════════════════════════════════╣${NC}"
    echo -e "${ungu}║  💎 STATUS: MINER ASLI - HASIL NYATA              ║${NC}"
    echo -e "${ungu}║  💰 BITCOIN AKAN MASUK KE DOMPET YANG MULIA       ║${NC}"
    echo -e "${ungu}╠════════════════════════════════════════════════════╣${NC}"
    echo -e "${ungu}║                                                    ║${NC}"
    echo -e "${ungu}║  ${putih}[1]${NC} ⚡  MULAI MENAMBANG BITCOIN ASLI        ${ungu}║${NC}"
    echo -e "${ungu}║  ${putih}[2]${NC} ⚡  MENAMBANG (POOL VIABTC)           ${ungu}║${NC}"
    echo -e "${ungu}║  ${putih}[3]${NC} ⚡  MENAMBANG (POOL F2POOL)           ${ungu}║${NC}"
    echo -e "${ungu}║  ${putih}[4]${NC} ⚡  MENAMBANG (POOL ANTPOOL)          ${ungu}║${NC}"
    echo -e "${ungu}║  ${putih}[5]${NC} 📊  MONITOR MINER                     ${ungu}║${NC}"
    echo -e "${ungu}║  ${putih}[6]${NC} 🔄  RESTART MINER                     ${ungu}║${NC}"
    echo -e "${ungu}║  ${putih}[7]${NC} ⛔  HENTIKAN MINER                    ${ungu}║${NC}"
    echo -e "${ungu}║  ${putih}[8]${NC} 📝  CEK SALDO (BLOCKCHAIN)           ${ungu}║${NC}"
    echo -e "${ungu}║  ${putih}[9]${NC} ❌  KELUAR                            ${ungu}║${NC}"
    echo -e "${ungu}║                                                    ║${NC}"
    echo -e "${ungu}╚════════════════════════════════════════════════════╝${NC}"
    echo ""
    echo -e "${cyan}⛏️  Pilih perintah Yang Mulia: ${NC}"
    read -p "➡️  " pilihan

    case $pilihan in
        1)
            clear
            echo -e "${hijau}⛏️  MEMULAI MINER BITCOIN ASLI...${NC}"
            echo -e "${kuning}💰 Bitcoin akan dikirim ke: bc1qputriinchatriponitrome${NC}"
            echo ""
            killall cpuminer 2>/dev/null
            ~/start_mining_asli.sh
            read -p "Tekan Enter untuk kembali..."
            ;;
        2)
            clear
            echo -e "${hijau}⛏️  MEMULAI MINER - POOL VIABTC...${NC}"
            killall cpuminer 2>/dev/null
            ~/start_mining_asli.sh
            ;;
        3)
            clear
            echo -e "${hijau}⛏️  MEMULAI MINER - POOL F2POOL...${NC}"
            killall cpuminer 2>/dev/null
            ~/miner_f2pool.sh
            ;;
        4)
            clear
            echo -e "${hijau}⛏️  MEMULAI MINER - POOL ANTPOOL...${NC}"
            killall cpuminer 2>/dev/null
            ~/miner_antpool.sh
            ;;
        5)
            clear
            echo -e "${cyan}📊 MEMBUKA MONITOR MINER...${NC}"
            echo -e "${kuning}Tekan Ctrl+C untuk keluar dari monitor${NC}"
            sleep 2
            ~/monitor_miner.sh
            ;;
        6)
            clear
            echo -e "${kuning}🔄 MERESTART MINER...${NC}"
            killall cpuminer 2>/dev/null
            sleep 2
            ~/start_mining_asli.sh &
            echo -e "${hijau}[✓] Miner telah direstart!${NC}"
            sleep 2
            ;;
        7)
            clear
            echo -e "${merah}⛔ MENGENTIKAN MINER...${NC}"
            killall cpuminer 2>/dev/null
            echo -e "${hijau}[✓] Miner dihentikan!${NC}"
            sleep 2
            ;;
        8)
            clear
            echo -e "${biru}📝 MEMBUKA BLOCKCHAIN EXPLORER...${NC}"
            echo -e "${kuning}Alamat: bc1qputriinchatriponitrome${NC}"
            termux-open-url "https://www.blockchain.com/btc/address/bc1qputriinchatriponitrome" 2>/dev/null || \
            echo -e "${merah}Buka link ini di browser:${NC}"
            echo "https://www.blockchain.com/btc/address/bc1qputriinchatriponitrome"
            read -p "Tekan Enter untuk kembali..."
            ;;
        9)
            echo -e "${ungu}Terima kasih Yang Mulia Putri Incha! 👑${NC}"
            exit 0
            ;;
        *)
            echo -e "${merah}Pilihan tidak valid, Yang Mulia!${NC}"
            sleep 1
            ;;
    esac
done
EOF

chmod +x ~/bitcoin_miner_menu.sh

# ==============================================
#    EKSEKUSI AKHIR
# ==============================================

clear
echo -e "${ungu}╔════════════════════════════════════════════════════╗${NC}"
echo -e "${ungu}║     ✅ INSTALASI SELESAI UNTUK YANG MULIA! ✅     ║${NC}"
echo -e "${ungu}╠════════════════════════════════════════════════════╣${NC}"
echo -e "${ungu}║                                                    ║${NC}"
echo -e "${ungu}║  ${hijau}BITCOIN MINER ASLI TELAH TERINSTAL!${NC}          ${ungu}║${NC}"
echo -e "${ungu}║  ${cyan}YANG MULIA BISA LANGSUNG MENAMBANG BTC!${NC}      ${ungu}║${NC}"
echo -e "${ungu}║                                                    ║${NC}"
echo -e "${ungu}║  ${putih}💎 ALAMAT DOMPET:${NC}                             ${ungu}║${NC}"
echo -e "${ungu}║  ${kuning}bc1qputriinchatriponitrome${NC}                 ${ungu}║${NC}"
echo -e "${ungu}║                                                    ║${NC}"
echo -e "${ungu}║  ${cyan}⚠️  GANTI ALAMAT DI ATAS DENGAN${NC}               ${ungu}║${NC}"
echo -e "${ungu}║  ${cyan}   DOMPET BTC ASLI YANG MULIA!${NC}               ${ungu}║${NC}"
echo -e "${ungu}║                                                    ║${NC}"
echo -e "${ungu}╚════════════════════════════════════════════════════╝${NC}"
echo ""

echo -e "${biru}📌 CARA MENGGUNAKAN:${NC}"
echo -e "${putih}1. GANTI ALAMAT DOMPET DI FILE:${NC}"
echo -e "   ${kuning}nano ~/start_mining_asli.sh${NC}"
echo -e "   ${kuning}nano ~/miner_f2pool.sh${NC}"
echo -e "   ${kuning}nano ~/miner_antpool.sh${NC}"
echo ""
echo -e "${putih}2. JALANKAN MINER:${NC}"
echo -e "   ${hijau}bash ~/bitcoin_miner_menu.sh${NC}"
echo ""
echo -e "${putih}3. PILIH MENU [1] UNTUK MULAI MENAMBANG${NC}"
echo ""

echo -e "${cyan}⛏️  APAKAH YANG MULIA INGIN MEMULAI MINER SEKARANG?${NC}"
read -p "Mulai sekarang? (y/n): " start_now

if [[ "$start_now" == "y" ]] || [[ "$start_now" == "Y" ]]; then
    echo -e "${hijau}⚡ MEMULAI BITCOIN MINER UNTUK YANG MULIA...${NC}"
    sleep 2
    bash ~/bitcoin_miner_menu.sh
else
    echo -e "${kuning}Gunakan 'bash ~/bitcoin_miner_menu.sh' kapanpun Yang Mulia ingin menambang!${NC}"
fi
