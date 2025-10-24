# Comandos usados en Arch Linux

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

### hibernation
```
# Setup
lsblk -l
// get the uuid of the SWAP partition
sudo nano /etc/default/grub
// edit the next line and write the swap partition uuid
GRUB_CMDLINE_LINUX_DEFAULT="quiet resume=UUID=<tu-uuid-de-particion-swap>"
// exit nano
sudo nano /etc/mkinitcpio.conf
// busca la linea sin comentar que pone: HOOKS=(base udev autodetect microcode modconf kms keyboard keymap consolefont block filesystems fsck)
// agrega resume despues de udev
HOOKS=(base udev resume autodetect microcode modconf kms keyboard keymap consolefont block filesystems fsck)
// exit nano
sudo mkinitcpio -P
sudo grub-mkconfig -o /boot/grub/grub.cfg
```

### grub
```
# Install
Still not covered

# Edit
sudo nano /etc/default/grub
// edit the file
sudo grub-mkconfig -o /boot/grub/grub.cfg # to persist changes
```

### systemd-boot
```
# Switching from GRUB to systemd-boot

This guide is for systems using UEFI and having the FAT32 EFI System Partition mounted at /boot.


# Display all partition identifiers (UUIDs and PARTUUIDs).
# Find the partition mounted as '/' (it's the large Linux filesystem) and copy its PARTUUID.

blkid

# // Action: Copy the PARTUUID of the partition mounted as '/'. 
# // Example PARTUUID: b97646ef-527c-4cc7-9b38-eb6e8f0c38ae

/intel-ucode.img
/amd-ucode.img

# Install your microcode package (do only the one your CPU is):
#sudo pacman -S intel-ucode
#sudo pacman -S amd-ucode

# Install systemd-boot
sudo bootctl install

# Create the main loader configuration file
sudo nano /boot/loader/loader.conf

# In my case, file content should be:
default arch
timeout 0
editor no

# Create the Arch Boot Entry
# Create the entry file (named 'arch.conf') using the PARTUUID copied in Step 1.
sudo nano /boot/loader/entries/arch.conf

# File contents (REPLACE YOUR-ROOT-PARTUUID-HERE and choose ONLY ONE microcode line):
title   Arch Linux
linux   /vmlinuz-linux
#initrd  /intel-ucode.img
#initrd /amd-ucode.img
initrd  /initramfs-linux.img
options root=PARTUUID=YOUR-ROOT-PARTUUID-HERE rw

# Reinstall Kernel (Ensures files are present for systemd-boot)
# This regenerates and places all images (vmlinuz, initramfs, microcode) correctly onto /boot.
sudo pacman -S linux

# Verify Configuration
bootctl list

# Cleanup and Finalization
# Only proceed with this section after `bootctl list` shows no errors.

# Remove GRUB packages
sudo pacman -Rns grub os-prober

# Remove residual GRUB files from the /boot partition
sudo rm -rf /boot/grub /boot/EFI/GRUB

# Time to reboot and pray
reboot

# Note: To access the systemd-boot menu after setting timeout 0, press and hold the SPACE bar during the brief boot window.
```

### yay
```
# Install
still not covered

# Update
yay

# Install package
yay -S package

# Uninstall package
yay -Rns package

# Clear cached packages
```

### DESHABILITAR baloo_file_ext
```
// Primero vemos que programas usan baloo como dependencia.
pacman -Qi baloo | grep "Required By"
// Si tiene un alto consumo de CPU lo deshabilitamos por mal funcionamiento.
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

### ~/scritps/ggui
```
#!/bin/bash
killall plasmashell > /dev/null 2>&1; plasmashell > /dev/null 2>&1 &
```

### ~/scripts/upup
```
#!/bin/bash
yay -Syu --noconfirm --needed
yay -Sc --noconfirm

```

### DESCOMPRIMIR rar | tar.gz
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

### ssh keychain
```
yay -S keychain
# now append to ~/.bashrc the next command
export SSH_AUTH_SOCK=$XDG_RUNTIME_DIR/ssh-agent.socket
```

### github-cli
```
yay -S github-cli
gh auth login
cd Proyect
git init -b main
gh repo create <ReplaceProjectName> --<private/public> --source=.
git push origin main
git fetch
git merge origin
```

### reboot ui
```
systemctl restart display-manager.service
```

### AGREGAR CONEXION VPN WIREGUARD
```
# El archivo de la conexion de wireguard es un <nombre_archivo>.conf
nmcli connection import type wireguard file <yourfilehere>
```

### INSTALAR konsave PARA BACKUP DE GUI
```
# NOT WORKING
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

### n8n
```
# Do only 1 time
docker volume create n8n_data

# Do this whenever you want to run n8n
docker run -it --rm  --name n8n  -p 5678:5678  -e GENERIC_TIMEZONE="Europe/Madrid"  -e TZ="Europe/Madrid"  -e N8N_ENFORCE_SETTINGS_FILE_PERMISSIONS=true  -e N8N_RUNNERS_ENABLED=true  -v n8n_data:/home/node/.n8n  docker.n8n.io/n8nio/n8n
```

### man-pages
```
yay -S man-pages
```

### qemu
```
yay -S qemu qemu-emulators-full virt-manager virt-viewer dnsmasq vde2 bridge-utils openbsd-netcat libvirt
sudo systemctl enable libvirtd
sudo systemctl start --now libvirtd
newgrp libvirt
sudo usermod -aG libvirt $(whoami)
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

### passwordless ssh conections
```
ssh-copy-id user@domain
# now enter the password
# then try to ssh user@domain
# et voila
```

### f5vpn
```
#Install
yay -S f5vpn
```

### iperf3
```
# Install
yay -S iperf3
```

### kid3
```
# Install (Info: Used to add/edit file tags and add png covers to sound files)
yay -S kid3

# Use example
kid3 music.mp3
// drag and drop an image
// click save
```

### edb
```
# Install
yay -S edb-debugger
```

### configuradorfnmt
```
# Install
yay -S configuradorfnmt
```

### btop
```
# Install
yay -s btop
```
### docker-desktop
```
# Install
https://docs.docker.com/desktop/setup/install/linux/
```
