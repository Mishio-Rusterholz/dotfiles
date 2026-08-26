#!/usr/bin/env bash 
export DEBIAN_FRONTEND=noninteractive
sudo apt update
sudo apt install -yqq curl

#### Pixi
curl -fsSL https://pixi.sh/install.sh | sh -s -- -y

#### uv
curl -LsSf https://astral.sh/uv/install.sh | sh 

#### flatpak 
sudo apt update 
sudo apt install flatpak gnome-software-plugin-flatpak -y
flatpak remote-add --if-not-exists --user flathub https://dl.flathub.org/repo/flathub.flatpakrepo

#### Cargo
sudo apt install -yqq build-essential
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
