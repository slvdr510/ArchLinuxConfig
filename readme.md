# Comandos que he ido usando en Arch Linux

### DESHABILITAR baloo_file_ext
Primero vemos que programas usan baloo como dependencia.
Si tiene un alto consumo de CPU lo deshabilitamos por mal funcionamiento.
```
pacman -Qi baloo | grep "Required By"
sudo balooctl disable
```

### .bashrc
```
# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'

PS1="\u@\h \w \$ "
export PATH=".:$PATH:$PATH/myScripts"
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
```
yay -Syu
sudo pacman -Syu
```

### DESCOMPRIMIR UN ARCHIVO rar o tar.gz
```
unrar x *.rar
tar xvzf *.tar.gz
```

### VER AJUSTES DE REDES
```
ip addr
```

### VER MODELO EQUIPO
```
cat /sys/class/dmi/id/product_name
```

### VER COMPONENTES DEL EQUIPO
```
sudo lshw
```

### AGREGAR SSH KEY EN ARCH
```
pacman -S keychain
```
now append to ~/.bashrc the next command
```
export SSH_AUTH_SOCK=$XDG_RUNTIME_DIR/ssh-agent.socket
```

### CREAR REPOSITORIO GIT
```
mkdir Proyect
cd Proyect
git init -b main
echo "#Proyect" >> readme.md
git add .
git commit -m "First commit"
```

### CREAR REPOSITORIO DE GITHUB DESDE TERMINAL
```
cd Proyect
sudo pacman -S github-cli
gh auth login
gh repo create Proyect --private --source=.
git push origin main
```


### TRAER CAMBIOS DE GITHUB
```
git fetch origin
```

### INTEGRAR CAMBIOS DE GITHUB
```
git merge origin
```

### REINICIAR INTERFAZ GRAFICA
ctrl + alt + f2
```
systemctl restart display-manager.service
```

### AGREGAR CONEXION VPN WIREGUARD
archivo de la conexion de wireguard es un <nombre_archivo>.conf
```
nmcli connection import type wireguard file <yourfilehere>
```



### INSTALAR konsave PARA BACKUP DE GUI
```
python -m pipx install konsave
pipx install setuptools
pipx inject konsave setuptools
konsave --save <nombre-plantilla>
konsave --list
konsave --apply <id-plantilla>
```

### INSTALAR Docker
Note that docker.service starts the service on boot, whereas docker.socket starts Docker on first usage which can decrease boot times
```
systemctl enable docker.socket
```


### Docker n8n
```
docker volume create n8n_data
```
```
docker run -it --rm  --name n8n  -p 5678:5678  -e GENERIC_TIMEZONE="Europe/Madrid"  -e TZ="Europe/Madrid"  -e N8N_ENFORCE_SETTINGS_FILE_PERMISSIONS=true  -e N8N_RUNNERS_ENABLED=true  -v n8n_data:/home/node/.n8n  docker.n8n.io/n8nio/n8n
```

### INSTALAR man
```
sudo pacman -S man-pages
```
