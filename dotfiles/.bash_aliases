# Fix theme for bat
alias bat='batcat --theme=Nord'
alias bap='bat -P'
alias cat='bat -pP'
alias fd='fdfind'
# Fix fastfetch logo
alias fastfetch='fastfetch --logo ubuntu_old'
# ls aliases
alias ls='eza --icons auto'
alias la='ls -l --group-directories-first --smart-group --time-style long-iso'
alias ll='la -a' 
alias l='ls -d'
# Util
alias src='. ~/.bashrc'
alias k='kubectl'
alias x='xsel -b'
alias y='yazi'
alias gho='gh repo view --web -b $(git branch --show-current)'
alias upd8='sudo bash -c \
            "apt update ; \
             apt upgrade -yqq ; \
             apt autoremove -yqq ; \
             snap refresh ; \
             flatpak update --assumeyes ; " \
            cargo install-update -a ; \
            uv self update ; \
            pixi self-update ; \
            docker system prune --force ; \
            rustup update '
alias evct='command -v kubectl >/dev/null && k drain $(hostname) --ignore-daemonsets --delete-emptydir-data --force '
alias rbt='evct ; \
           upd8 ; \
           reboot '
alias dwn='evct ; \
           upd8 ; \
           shutdown now '
alias lunch='uvx termdown 3600 -c 120 -f roman -T "Lunch break" && nyancat'
