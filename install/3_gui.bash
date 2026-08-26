#!/usr/bin/env bash 
export DEBIAN_FRONTEND=noninteractive
cd "$(dirname "${BASH_SOURCE[0]}")/.."

#### Google Chrome
wget -P ~/Downloads/ https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo apt install -y ~/Downloads/google-chrome-stable*.deb && rm ~/Downloads/google-chrome-stable*.deb

#### VSCode
wget -O ~/Downloads/vscode-stable.deb "https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64"
sudo apt install -y ~/Downloads/vscode-stable.deb && rm ~/Downloads/vscode-stable.deb
./vscode/extensions.bash
# VSCode settings are linked in settings.bash

#### Slack
sudo mkdir -m755 -p /etc/apt/keyrings
curl -fsSL https://packagecloud.io/slacktechnologies/slack/gpgkey | sudo gpg --dearmor -o /etc/apt/keyrings/slack-archive-keyring.gpg
echo "deb [signed-by=/etc/apt/keyrings/slack-archive-keyring.gpg] https://packagecloud.io/slacktechnologies/slack/debian/ jessie main" | sudo tee /etc/apt/sources.list.d/slack.list > /dev/null
sudo apt update
sudo apt install -yqq slack-desktop

#### Wireshark
sudo apt install -yqq wireshark
sudo dpkg-reconfigure wireshark-commo
sudo usermod -aG wireshark $(whoami)

#### CloudCompare
flatpak install -y flathub org.cloudcompare.CloudCompare
flatpak override --user --filesystem=host org.cloudcompare.CloudCompare

#### QGIS
sudo apt install -y gnupg software-properties-common
sudo mkdir -m755 -p /etc/apt/keyrings
sudo wget -O /etc/apt/keyrings/qgis-archive-keyring.gpg https://download.qgis.org/downloads/qgis-archive-keyring.gpg
. /etc/os-release

cat << EOF | sudo tee /etc/apt/sources.list.d/qgis.sources > /dev/null
Types: deb deb-src
URIs: https://qgis.org/debian
Suites: ${UBUNTU_CODENAME}
Architectures: amd64
Components: main
Signed-By: /etc/apt/keyrings/qgis-archive-keyring.gpg
EOF

sudo apt update
sudo apt install -yqq qgis qgis-plugin-grass

#### Discord
wget -O ~/Downloads/discord.deb "https://discord.com/api/download?platform=linux&format=deb"
sudo apt install -y ~/Downloads/discord.deb && rm ~/Downloads/discord.deb

#### RustDesk
wget -O ~/Downloads/rustdesk.deb "$(curl -fsSL https://api.github.com/repos/rustdesk/rustdesk/releases/latest | grep -oP '"browser_download_url": "\K[^"]+x86_64\.deb')"
sudo apt install -y ~/Downloads/rustdesk.deb && rm ~/Downloads/rustdesk.deb

#### misc
flatpak remote-add --system --if-not-exists appcenter https://flatpak.elementary.io/repo.flatpakrepo
flatpak install -y --system appcenter com.github.phase1geo.annotator
# flatpak install flathub org.gnome.Showtime # preinstalled on Ubuntu 26