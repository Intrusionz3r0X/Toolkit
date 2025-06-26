#!/bin/bash

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[1;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Define Tools directory relative to current path
TOOLS_DIR="$PWD/Tools"
mkdir -p "$TOOLS_DIR"

log() {
    echo -e "${BLUE}[+]${NC} $1"
}

warn() {
    echo -e "${YELLOW}[!]${NC} $1"
}

error() {
    echo -e "${RED}[-]${NC} $1"
}

success() {
    echo -e "${GREEN}[✔]${NC} $1"
}

# Update & install required packages
log "Updating package list and installing dependencies..."
sudo apt-get update -y
sudo apt-get install -y git wget unzip tar gunzip xxd moreutils curl docker.io docker-compose mingw-w64 \
    netexec seclists bloodhound.py certipy-ad bloodyad hoaxshell neo4j feroxbuster enum4linux-ng coercer \
    ghidra dnschef krb5-config krb5-user rlwrap kpcli

# Enable Docker
sudo systemctl enable docker --now
sudo usermod -aG docker "$USER"

# Decompress rockyou.txt if found
ROCKYOU="/usr/share/wordlists/rockyou.txt.gz"
if [ -f "$ROCKYOU" ]; then
    log "Decompressing rockyou.txt..."
    sudo gunzip -f "$ROCKYOU"
else
    warn "rockyou.txt.gz not found. Skipping."
fi

# Sysinternals
log "Downloading Sysinternals Suite..."
mkdir -p "$TOOLS_DIR/Sysinternals"
cd "$TOOLS_DIR/Sysinternals"
wget -q https://download.sysinternals.com/files/SysinternalsSuite.zip
unzip -q SysinternalsSuite.zip && rm SysinternalsSuite.zip

# GitHub repositories
log "Cloning GitHub repositories..."
REPOS=(
    "https://github.com/Flangvik/SharpCollection.git"
    "https://github.com/TheWover/donut.git"
    "https://github.com/Intrusionz3r0X/CipherForge.git"
    "https://github.com/Intrusionz3r0X/PhantomLdr.git"
    "https://github.com/dirkjanm/PKINITtools.git"
    "https://github.com/NetSPI/PowerUpSQL.git"
    "https://github.com/itm4n/PrivescCheck.git"
    "https://github.com/ShutdownRepo/pywhisker.git"
    "https://github.com/Kevin-Robertson/Invoke-TheHash.git"
    "https://github.com/sosdave/KeyTabExtract.git"
    "https://github.com/Greenwolf/ntlm_theft.git"
    "https://github.com/Kevin-Robertson/Powermad.git"
    "https://github.com/xct/rcat.git"
    "https://github.com/cube0x0/KrbRelay.git"
    "https://github.com/Dec0ne/KrbRelayUp.git"
    "https://github.com/insidetrust/statistically-likely-usernames.git"
    "https://github.com/dirkjanm/krbrelayx.git"
    "https://github.com/t0thkr1s/gpp-decrypt.git"
    "https://github.com/Adkali/PowerJoker.git"
    "https://github.com/dagowda/DSViper.git"
    "https://github.com/RedSiege/EyeWitness.git"
    "https://github.com/michenriksen/aquatone.git"
    "https://github.com/CiscoCXSecurity/linikatz.git"
    "https://github.com/Hackndo/pyGPOAbuse.git"
    "https://github.com/ShutdownRepo/targetedKerberoast.git"
    "https://github.com/ropnop/kerbrute.git"

)

for REPO in "${REPOS[@]}"; do
    NAME=$(basename "$REPO" .git)
    log "Cloning $NAME..."
    git clone --quiet "$REPO" "$TOOLS_DIR/$NAME"
done

# Coercion tools
log "Downloading Coercion tools..."
mkdir -p "$TOOLS_DIR/Coercion"
cd "$TOOLS_DIR/Coercion"
wget -q https://raw.githubusercontent.com/Wh04m1001/DFSCoerce/main/dfscoerce.py
wget -q https://gist.githubusercontent.com/3xocyte/cfaf8a34f76569a8251bde65fe69dccc/raw/dementor.py
wget -q https://github.com/jtmpu/PrecompiledBinaries/raw/master/SpoolSample.exe
wget -q https://github.com/topotam/PetitPotam/raw/refs/heads/main/PetitPotam.exe
wget -q https://raw.githubusercontent.com/topotam/PetitPotam/refs/heads/main/PetitPotam.py

# Sliver C2
log "Setting up Sliver..."
mkdir -p "$TOOLS_DIR/sliver"
cd "$TOOLS_DIR/sliver"
wget -q https://github.com/BishopFox/sliver/releases/download/v1.5.43/sliver-client_linux
wget -q https://github.com/BishopFox/sliver/releases/download/v1.5.43/sliver-server_linux
chmod +x sliver-*

# GodPotato
log "Setting up Fresh Potatos..."
mkdir -p "$TOOLS_DIR/FreshPotatos"
cd "$TOOLS_DIR/FreshPotatos"
wget -q https://github.com/BeichenDream/GodPotato/releases/download/V1.20/GodPotato-NET4.exe
wget -q https://github.com/itm4n/PrintSpoofer/releases/download/v1.0/PrintSpoofer64.exe
wget -q https://github.com/itm4n/PrintSpoofer/releases/download/v1.0/PrintSpoofer32.exe
wget -q https://github.com/antonioCoco/JuicyPotatoNG/releases/download/v1.1/JuicyPotatoNG.zip
wget -q https://github.com/ohpe/juicy-potato/releases/download/v0.1/JuicyPotato.exe

# CodemerxDecompile
log "Setting up CodemerxDecompile..."
mkdir -p "$TOOLS_DIR/CodemerxDecompile"
cd "$TOOLS_DIR/CodemerxDecompile"
wget -q https://github.com/codemerx/CodemerxDecompile/releases/download/1.5.0/CodemerxDecompile-linux-x64.tar.gz
tar -xzf CodemerxDecompile-linux-x64.tar.gz && rm CodemerxDecompile-linux-x64.tar.gz

# LaZagne
log "Setting up LaZagne..."
mkdir -p "$TOOLS_DIR/LaZagne"
cd "$TOOLS_DIR/LaZagne"
wget -q https://github.com/AlessandroZ/LaZagne/releases/download/v2.4.7/LaZagne.exe

# Chisel
log "Setting up Chisel..."
mkdir -p "$TOOLS_DIR/chisel"
cd "$TOOLS_DIR/chisel"
wget -q https://github.com/jpillora/chisel/releases/download/v1.10.1/chisel_1.10.1_linux_amd64.gz
wget -q https://github.com/jpillora/chisel/releases/download/v1.10.1/chisel_1.10.1_windows_amd64.gz
gunzip chisel_1.10.1_linux_amd64.gz
gunzip chisel_1.10.1_windows_amd64.gz

# Ligolo-ng
log "Setting up Ligolo-ng..."
mkdir -p "$TOOLS_DIR/ligolo-ng"
cd "$TOOLS_DIR/ligolo-ng"
wget -q https://github.com/nicocha30/ligolo-ng/releases/download/v0.8.2/ligolo-ng_agent_0.8.2_linux_amd64.tar.gz
wget -q https://github.com/nicocha30/ligolo-ng/releases/download/v0.8.2/ligolo-ng_proxy_0.8.2_linux_amd64.tar.gz
wget -q https://github.com/nicocha30/ligolo-ng/releases/download/v0.8.2/ligolo-ng_agent_0.8.2_windows_amd64.zip
wget -q https://github.com/nicocha30/ligolo-ng/releases/download/v0.8.2/ligolo-ng_proxy_0.8.2_windows_amd64.zip
tar -xzf ligolo-ng_agent_0.8.2_linux_amd64.tar.gz && rm ligolo-ng_agent_0.8.2_linux_amd64.tar.gz
tar -xzf ligolo-ng_proxy_0.8.2_linux_amd64.tar.gz && rm ligolo-ng_proxy_0.8.2_linux_amd64.tar.gz
unzip -q ligolo-ng_agent_0.8.2_windows_amd64.zip && rm ligolo-ng_agent_0.8.2_windows_amd64.zip
unzip -q ligolo-ng_proxy_0.8.2_windows_amd64.zip && rm ligolo-ng_proxy_0.8.2_windows_amd64.zip

# PowerShell scripts
log "Downloading PowerShell tools..."
cd "$TOOLS_DIR"
wget -q https://raw.githubusercontent.com/PowerShellMafia/PowerSploit/master/Recon/PowerView.ps1
wget -q https://raw.githubusercontent.com/Kevin-Robertson/Inveigh/master/Inveigh.ps1 -O Inveigh.ps1
wget -q https://raw.githubusercontent.com/leoloobeek/LAPSToolkit/master/LAPSToolkit.ps1 -O LAPSToolkit.ps1
wget -q https://raw.githubusercontent.com/fashionproof/EnableAllTokenPrivs/master/EnableAllTokenPrivs.ps1 -O EnableAllTokenPrivs.ps1

# Windows tools
log "Downloading Windows tools..."
cd "$TOOLS_DIR"
wget -q https://github.com/itm4n/FullPowers/releases/download/v0.1/FullPowers.exe
wget -q https://github.com/jellever/StreamDivert/releases/download/v1.1/StreamDivert.x64.zip
wget -q https://github.com/antonioCoco/RunasCs/releases/download/v1.5/RunasCs.zip
unzip -q StreamDivert.x64.zip && rm StreamDivert.x64.zip
unzip -q RunasCs.zip && rm RunasCs.zip

# Neovim
log "Installing Neovim..."
cd "$TOOLS_DIR"
curl -s -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz
tar -C "$TOOLS_DIR" -xzf nvim-linux-x86_64.tar.gz && rm nvim-linux-x86_64.tar.gz
echo -e "${YELLOW}Add the following line to your shell config (~/.bashrc or ~/.zshrc):"
echo -e "export PATH=\"\$PATH:$TOOLS_DIR/nvim-linux64/bin\"${NC}"

# BloodHound CE
log "Installing BloodHound CE..."
mkdir -p "$TOOLS_DIR/Bloodhound-ce"
cd "$TOOLS_DIR/Bloodhound-ce"
wget -q https://github.com/SpecterOps/bloodhound-cli/releases/latest/download/bloodhound-cli-linux-amd64.tar.gz
tar -xvzf bloodhound-cli-linux-amd64.tar.gz && rm bloodhound-cli-linux-amd64.tar.gz
./bloodhound-cli install

success "All tools installed in: $TOOLS_DIR"
