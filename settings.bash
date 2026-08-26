#!/usr/bin/env bash
set -e
cd "$(dirname "${BASH_SOURCE[0]}")"

if [ "$EUID" -eq 0 ] || [ "$#" -ne 2 ]; then
    echo "Run as: bash settings.bash \"Your Name\" \"you@example.com\"" >&2
    exit 1
fi

GIT_NAME=$1
GIT_EMAIL=$2

#### symlink settings
mkdir -p "$HOME/.config/ghostty" "$HOME/.config/Code/User" "$HOME/.config/mozc"
grep -qxF "source $(pwd)/dotfiles/.bashrc" "$HOME/.bashrc" 2>/dev/null || \
     echo "source $(pwd)/dotfiles/.bashrc" >> "$HOME/.bashrc"
ln -sf "$(pwd)/dotfiles/.bash_aliases"  "$HOME/.bash_aliases"
cp -f "$(pwd)/dotfiles/.gitconfig"      "$HOME/.gitconfig"
cat >> "$HOME/.gitconfig" <<EOF
[user]
	name = $GIT_NAME
	email = $GIT_EMAIL
EOF
ln -sf "$(pwd)/.config/background"   "$HOME/.config/background"
ln -sf "$(pwd)/.config/ghostty/config"   "$HOME/.config/ghostty/config"
ln -sf "$(pwd)/.config/starship.toml"    "$HOME/.config/starship.toml"
ln -sf "$(pwd)/gnome/xdg-terminals.list" "$HOME/.config/xdg-terminals.list"
ln -sf "$(pwd)/vscode/settings.json"     "$HOME/.config/Code/User/settings.json"
ln -sf "$(pwd)/vscode/keybindings.json"  "$HOME/.config/Code/User/keybindings.json"
ln -sf "$(pwd)/.config/mozc/ibus_config.textproto" "$HOME/.config/mozc/ibus_config.textproto"

#### 日本語入力 (Mozc) — apply now if a session is running; otherwise next login picks it up
if command -v ibus >/dev/null; then
    ibus write-cache >/dev/null 2>&1 || true
    ibus restart     >/dev/null 2>&1 || true
fi

#### Gnome settings
sed "s#{{HOME}}#$HOME#g" gnome/settings.dconf | dconf load /

#### Power mode
command -v powerprofilesctl >/dev/null && powerprofilesctl set performance

#### Create ssh key (skips if one already exists)
[ -f "$HOME/.ssh/id_ed25519" ] || ssh-keygen -t ed25519 -C "$GIT_EMAIL" -f "$HOME/.ssh/id_ed25519"
