# 🛠️ Red Team Toolkit Installer

This script automates the installation and setup of over 70 essential tools used in Red Team operations, ethical hacking, and post-exploitation on **Kali Linux** or any **Debian-based** system.

> ⚠️ **Important:** Do NOT run this script as `root`. Use a normal user account; the script will elevate privileges when needed.

---

## 🧩 Features

✅ Installs 20+ key tools from official repositories (APT).

✅ Automatically downloads and configures 30+ GitHub repositories.

✅ Organizes all tools inside `~/Documents/Tools`.

✅ Groups tools by category: C2, tunneling, AD exploitation, privilege escalation, PowerShell, coercion, and more.

✅ Includes tools for both **Windows** and **Linux** environments.

---

## 📦 Included Tools

### ⚔️ Command & Control (C2)
- [Sliver C2](https://github.com/BishopFox/sliver)

### 🧬 Active Directory / Post-Exploitation
- [BloodHound CE](https://github.com/SpecterOps/bloodhound-cli)
- BloodHound Fork (ly4k)
- [SharpHound](https://github.com/SpecterOps/SharpHound)
- [SharpCollection](https://github.com/Flangvik/SharpCollection)
- [Certipy](https://github.com/ly4k/Certipy)
- PowerShell tools: PowerView, Inveigh, LAPSToolkit
- [KrbRelay, KrbRelayUp, krbrelayx](https://github.com/cube0x0/KrbRelay)

### 🌐 Tunneling / Pivoting
- [Ligolo-ng](https://github.com/nicocha30/ligolo-ng)
- [Chisel](https://github.com/jpillora/chisel)
- [StreamDivert](https://github.com/jellever/StreamDivert)

### 🧪 Privilege Escalation (Windows)
- [GodPotato-NET4](https://github.com/BeichenDream/GodPotato)
- [PrintSpoofer](https://github.com/itm4n/PrintSpoofer)
- [JuicyPotato, JuicyPotatoNG](https://github.com/ohpe/juicy-potato)

### 🪓 Coercion / RPC Abuse
- [PetitPotam](https://github.com/topotam/PetitPotam)
- [DFSCoerce](https://github.com/Wh04m1001/DFSCoerce)
- Dementor

### 🔐 Credentials / Passwords
- [LaZagne](https://github.com/AlessandroZ/LaZagne)
- rockyou.txt (auto decompressed if present)

### 🔁 PowerShell Tools
- PowerView.ps1
- Inveigh.ps1
- LAPSToolkit.ps1
- EnableAllTokenPrivs.ps1

### 🧠 Other Highlights
- [RunasCs](https://github.com/antonioCoco/RunasCs)
- [CodemerxDecompile](https://github.com/codemerx/CodemerxDecompile)
- [FullPowers](https://github.com/itm4n/FullPowers)
- [Neo4j](https://neo4j.com/)
- Portable [Neovim](https://github.com/neovim/neovim)
- [Sysinternals Suite](https://learn.microsoft.com/en-us/sysinternals/)

---

## 🛠️ Installation

```bash
# 1. Download the script
wget https://raw.githubusercontent.com/Intrusionz3r0X/Toolkit/refs/heads/main/RedTeamTools.sh

# 2. Make it executable
chmod +x RedTeamTools.sh

# 3. Run it (⚠️ as normal user, NOT root)
./RedTeamTools.sh
