#!/bin/bash

# Check if running as root
if [ "$EUID" -ne 0 ]; then
    echo "Please run as root (sudo)."
    exit 1
fi

# Update & install tools via apt
echo "[+] Updating & installing packages..."
apt-get update -y
apt-get install -y netexec seclists bloodhound bloodhound.py certipy-ad bloodyad hoaxshell neo4j xxd moreutils feroxbuster enum4linux-ng coercer mingw-w64 docker.io

# Install docker
apt-get install -y docker.io docker-compose
sudo systemctl enable docker --now
sudo usermod -aG docker $USER

# Decompress rockyou.txt
echo "[+] Decompressing rockyou.txt..."
if [ -f "/usr/share/wordlists/rockyou.txt.gz" ]; then
    gunzip -f /usr/share/wordlists/rockyou.txt.gz
else
    echo "rockyou.txt.gz not found. Skipping."
fi

# Download Sysinternals Suite
echo "[+] Downloading SysinternalsSuite..."
mkdir -p /opt/Sysinternals
cd /opt/Sysinternals
wget -q https://download.sysinternals.com/files/SysinternalsSuite.zip
unzip -q SysinternalsSuite.zip
rm SysinternalsSuite.zip

# Clone GitHub repos into /opt
echo "[+] Cloning GitHub repositories..."
repos=(
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
    "https://github.com/fashionproof/EnableAllTokenPrivs.git"
    "https://github.com/Dec0ne/KrbRelayUp.git"
    "https://github.com/insidetrust/statistically-likely-usernames.git"
    "https://github.com/dirkjanm/krbrelayx.git"
    "https://github.com/t0thkr1s/gpp-decrypt.git"
    "https://github.com/topotam/PetitPotam.git"
)

for repo in "${repos[@]}"; do
    repo_name=$(basename "$repo" .git)
    echo "[+] Cloning $repo_name..."
    git clone "$repo" "/opt/$repo_name"
done

# Download Coercion Tools
echo "[+] Downloading Coercion Tools..."
mkdir -p /opt/Coercion
cd /opt/Coercion
wget -q https://raw.githubusercontent.com/Wh04m1001/DFSCoerce/refs/heads/main/dfscoerce.py
wget -q https://gist.githubusercontent.com/3xocyte/cfaf8a34f76569a8251bde65fe69dccc/raw/7c7f09ea46eff4ede636f69c00c6dfef0541cd14/dementor.py
wget -q https://github.com/jtmpu/PrecompiledBinaries/raw/refs/heads/master/SpoolSample.exe -O SpoolSample.exe

# Download Sliver (C2 Framework)
echo "[+] Setting up Sliver..."
mkdir -p /opt/sliver
cd /opt/sliver
wget -q https://github.com/BishopFox/sliver/releases/download/v1.5.43/sliver-client_linux
wget -q https://github.com/BishopFox/sliver/releases/download/v1.5.43/sliver-server_linux
chmod +x sliver-*

# Download GodPotato (PrivEsc)
echo "[+] Setting up GodPotato..."
mkdir -p /opt/GodPotato
cd /opt/GodPotato
wget -q https://github.com/BeichenDream/GodPotato/releases/download/V1.20/GodPotato-NET4.exe

# Download CodemerxDecompile (Decompiler)
echo "[+] Setting up CodemerxDecompile..."
mkdir -p /opt/CodemerxDecompile
cd /opt/CodemerxDecompile
wget -q https://github.com/codemerx/CodemerxDecompile/releases/download/1.5.0/CodemerxDecompile-linux-x64.tar.gz
tar -xzf CodemerxDecompile-linux-x64.tar.gz
rm CodemerxDecompile-linux-x64.tar.gz

# Download LaZagne (Password Recovery)
echo "[+] Setting up LaZagne..."
mkdir -p /opt/LaZagne
cd /opt/LaZagne
wget -q https://github.com/AlessandroZ/LaZagne/releases/download/v2.4.7/LaZagne.exe

# Download Chisel (Tunneling)
echo "[+] Setting up Chisel..."
mkdir -p /opt/chisel
cd /opt/chisel
wget -q https://github.com/jpillora/chisel/releases/download/v1.10.1/chisel_1.10.1_linux_amd64.gz
wget -q https://github.com/jpillora/chisel/releases/download/v1.10.1/chisel_1.10.1_windows_amd64.gz
gunzip chisel_1.10.1_linux_amd64.gz
unzip -q chisel_1.10.1_windows_amd64.gz

# Download Ligolo-ng (Tunneling)
echo "[+] Setting up Ligolo-ng..."
mkdir -p /opt/ligolo-ng
cd /opt/ligolo-ng
wget -q https://github.com/nicocha30/ligolo-ng/releases/download/v0.8.2/ligolo-ng_agent_0.8.2_linux_amd64.tar.gz
wget -q https://github.com/nicocha30/ligolo-ng/releases/download/v0.8.2/ligolo-ng_proxy_0.8.2_linux_amd64.tar.gz
wget -q https://github.com/nicocha30/ligolo-ng/releases/download/v0.8.2/ligolo-ng_agent_0.8.2_windows_amd64.zip
wget -q https://github.com/nicocha30/ligolo-ng/releases/download/v0.8.2/ligolo-ng_proxy_0.8.2_windows_amd64.zip
tar -xzf ligolo-ng_agent_0.8.2_linux_amd64.tar.gz
tar -xzf ligolo-ng_proxy_0.8.2_linux_amd64.tar.gz
unzip -q ligolo-ng_agent_0.8.2_windows_amd64.zip
unzip -q ligolo-ng_proxy_0.8.2_windows_amd64.zip

# Download PowerShell Tools
echo "[+] Downloading PowerShell Tools..."
mkdir -p /opt/PowerSploit
cd /opt/PowerSploit
wget -q https://raw.githubusercontent.com/PowerShellMafia/PowerSploit/refs/heads/master/Recon/PowerView.ps1
wget -q https://raw.githubusercontent.com/Kevin-Robertson/Inveigh/master/Inveigh.ps1 -O Inveigh.ps1
wget -q https://raw.githubusercontent.com/leoloobeek/LAPSToolkit/master/LAPSToolkit.ps1 -O LAPSToolkit.ps1

# Download Windows Tools
echo "[+] Downloading Windows Tools..."
mkdir -p /opt/Windows-Tools
cd /opt/Windows-Tools
wget -q https://github.com/jellever/StreamDivert/releases/download/v1.1/StreamDivert.x64.zip
wget -q https://github.com/antonioCoco/RunasCs/releases/download/v1.5/RunasCs.zip
unzip -q StreamDivert.x64.zip
unzip -q RunasCs.zip

echo "[+] Installation complete! All tools are in /opt."
