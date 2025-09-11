# Comandos que he ido usando en Arch Linux

### .bashrc
```
# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'

PS1="\u@\h \w \$ "
export PATH=".:$PATH"
export SSH_AUTH_SOCK=$XDG_RUNTIME_DIR/ssh-agent.socket
cd ./Escritorio/
```

### /etc/xdg/user-dirs.defaults
```
# Default settings for user directories
#
# The values are relative pathnames from the home directory and
# will be translated on a per-path-element basis into the users locale
#
DESKTOP=desktop
DOWNLOAD=downloads
TEMPLATES=templates
PUBLICSHARE=public
DOCUMENTS=documents
MUSIC=music  
PICTURES=pictures
VIDEOS=videos
```

### ~/.config/user-dirs.dirs
```
# This file is written by xdg-user-dirs-update
# If you want to change or add directories, just edit the line you're
# interested in. All local changes will be retained on the next run.
# Format is XDG_xxx_DIR="$HOME/yyy", where yyy is a shell-escaped
# homedir-relative path, or XDG_xxx_DIR="/yyy", where /yyy is an
# absolute path. No other format is supported.
#
XDG_DESKTOP_DIR="$HOME/desktop"
XDG_DOWNLOAD_DIR="$HOME/downloads"
XDG_TEMPLATES_DIR="$HOME/templates"
XDG_PUBLICSHARE_DIR="$HOME/public"
XDG_DOCUMENTS_DIR="$HOME/documents"
XDG_MUSIC_DIR="$HOME/music"
XDG_PICTURES_DIR="$HOME/pictures"
XDG_VIDEOS_DIR="$HOME/videos"
```

### ACTUALIZAR APPS
yay -Syu


### DESCOMPRIMIR UN ARCHIVO rar o tar.gz
unrar x *.rar
tar xvzf *.tar.gz


### VER AJUSTES DE REDES
ip addr


### VER MODELO EQUIPO
cat /sys/class/dmi/id/product_name


### VER COMPONENTES DEL EQUIPO
sudo lshw


### AGREGAR SSH KEY EN ARCH
pacman -S keychain
now append to ~/.bashrc the next command
export SSH_AUTH_SOCK=$XDG_RUNTIME_DIR/ssh-agent.socket


### CREAR REPOSITORIO GIT
mkdir Proyect
cd Proyect
git init -b main
echo "#Proyect" >> readme.md
git add .
git commit -m "First commit"


### CREAR REPOSITORIO DE GITHUB DESDE TERMINAL
cd Proyect
sudo pacman -S github-cli
gh auth login
gh repo create Proyect --private --source=.
git push origin main


### TRAER CAMBIOS DE GITHUB
git fetch origin


### INTEGRAR CAMBIOS DE GITHUB
git merge origin


### REINICIAR INTERFAZ GRAFICA
ctrl + alt + f2
systemctl restart display-manager.service


### AGREGAR CONEXION VPN WIREGUARD
nmcli connection import type wireguard file <yourfilehere>
el archivo será algo como home.conf


### INSTALAR konsave PARA BACKUP DE GUI
python -m pipx install konsave
pipx install setuptools
pipx inject konsave setuptools
konsave --save <nombre-plantilla>
konsave --list
konsave --apply <id-plantilla>
