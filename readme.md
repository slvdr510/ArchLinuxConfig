# Comandos que he ido usando en Arch Linux

### SETUP lang for locale
```
sudo nano /etc/locale.gen
# Uncoment the line you'd like, in my case:
en_US.UTF-8 UTF-8
es_ES.UTF-8 UTF-8
exit nano
sudo locale-gen
sudo nano /etc/locale.conf
# add/overwrite the next lines:
LANG=en_US.UTF-8
LC_TIME=es_ES.UTF-8
exit nano
unset LANG LC_CTYPE LC_NUMERIC LC_TIME LC_COLLATE LC_MONETARY LC_MESSAGES LC_PAPER LC_NAME LC_ADDRESS LC_TELEPHONE LC_MEASUREMENT LC_IDENTIFICATION LC_ALL
source /etc/profile.d/locale.sh
# log out your sesion and log in
# Now check with the next line in KDE plasma config it's all okey
cat ~/.config/plasma-localerc
```

### SETUP hibernation
```
lsblk -l
# get the uuid of the SWAP partition
sudo nano /etc/default/grub
# edit the next line and write the swap partition uuid
GRUB_CMDLINE_LINUX_DEFAULT="quiet resume=UUID=<tu-uuid-de-particion-swap>"
# exit nano
sudo nano /etc/mkinitcpio.conf
# busca la linea sin comentar que pone: HOOKS=(base udev autodetect microcode modconf kms keyboard keymap consolefont block filesystems fsck)
# agrega resume despues de udev
HOOKS=(base udev resume autodetect microcode modconf kms keyboard keymap consolefont block filesystems fsck)
# exit nano
sudo mkinitcpio -P
sudo grub-mkconfig -o /boot/grub/grub.cfg
```

### UPDATE grub timeout 
```
sudo nano /etc/default/grub
# Cambiar valor de GRUB_TIMEOUT
sudo grub-mkconfig -o /boot/grub/grub.cfg
```

### Install YAY
```
// Install proccess still not covered

// update packages
yay

// install package
yay -S package

// uninstall package
yay -Rns package
```

### DESHABILITAR baloo_file_ext
```
# Primero vemos que programas usan baloo como dependencia.
# Si tiene un alto consumo de CPU lo deshabilitamos por mal funcionamiento.
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
cd ~/desktop
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

### REINICIAR interfaz grafica KDE6
```
#!/bin/bash

#killall plasmashell; plasmashell &
killall plasmashell; plasmashell > /dev/null 2>&1 &
clear
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

### github-cli INSTALL
```
sudo pacman -S github-cli
gh auth login
```

### create github repository using terminal
```
cd Proyect
git init -b main
gh repo create <ReplaceProjectName> --<private/public> --source=.
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
DONT DO THIS -> ctrl + alt + f2 
```
systemctl restart display-manager.service
```

### AGREGAR CONEXION VPN WIREGUARD
```
# archivo de la conexion de wireguard es un <nombre_archivo>.conf
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

### INSTALAR qemu
```
sudo pacman -S qemu qemu-emulators-full virt-manager virt-viewer dnsmasq vde2 bridge-utils openbsd-netcat libvirt
sudo systemctl enable libvirtd
sudo systemctl start --now libvirtd
sudo usermod -aG libvirt $(whoami)
newgrp libvirt
sudo EDITOR=nano virsh net-edit default
sudo systemctl restart libvirtd
sudo virsh net-start default
sudo virsh net-autostart default
qemu-system-x86_64 --version
sudo virsh net-list --all
virt-manager
```

### SETUP bluetooth
```
sudo pacman -S bluez bluez-utils
sudo systemctl enable --now bluetooth.service
bluetoothctl
list
power on
quit
```

### ADD passwordless ssh conections
```
ssh-copy-id user@domain
# now enter the password
# then try to ssh user@domain
# et voila
```

### F5 VPN for my University conection
```
yay -S f5vpn
```

### iperf3 install
```
yay -S iperf3
```

### kid3 install
```
// Used to add/edit tags and add png covers to only sound files.
yay -S kid3
# example
# kid3 music.mp3
# drag and drop an image and click save
```
