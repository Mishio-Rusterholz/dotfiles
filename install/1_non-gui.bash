#!/usr/bin/env bash 
export DEBIAN_FRONTEND=noninteractive
sudo apt update

#### Essentials
sudo apt install -yqq curl wget gcc-15 g++-15 libssl-dev pkgconf build-essential sudo locales git tzdata ca-certificates openssh-server cifs-utils

#### CLI/TUI
sudo apt install -yqq \
    zstd gh bash-completion less nano rsync rclone trash-cli xsel sshfs ffmpeg libheif-examples speedtest-cli jq resvg \
    du-dust pastel fd-find fzf zoxide eza bat ripgrep git-delta btm htop btop nvtop p7zip-full clang-format \
    gnome-sushi file-roller gnome-tweaks nmap net-tools
sudo snap install dyff
uv tool install linecast
## charm
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://repo.charm.sh/apt/gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/charm.gpg
echo "deb [signed-by=/etc/apt/keyrings/charm.gpg] https://repo.charm.sh/apt/ * *" | sudo tee /etc/apt/sources.list.d/charm.list
sudo apt update && sudo apt install gum vhs ttyd 

#### GUI
sudo apt install -yqq gedit

#### Terminal
sudo snap install yazi --classic
sudo apt install -yqq starship fastfetch ghostty
# set ghostty as default terminal (x-terminal-emulator alternative; xdg-terminals.list is symlinked in settings.bash)
sudo update-alternatives --install /usr/bin/x-terminal-emulator x-terminal-emulator $(which ghostty) 50
sudo update-alternatives --set x-terminal-emulator $(which ghostty)

#### 日本語入力
sudo apt install -yqq ibus-mozc mozc-utils-gui
# ibus_config.textproto (active_on_launch: True) is symlinked by settings.bash

#### Clanker
curl -fsSL https://claude.ai/install.sh | bash

#### Misc
sudo apt install -yqq tty-clock nyancat lolcat figlet hollywood
sudo apt upgrade -yqq
