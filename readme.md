# Comandos que he ido usando en Arch Linux

## ACTUALIZAR APPS
yay -Syu

## DESCOMPRIMIR
unrar x *.rar
tar xvzf *.tar.gz

## REDES
ip addr

## VER MODELO EQUIPO
cat /sys/class/dmi/id/product_name

## VER COMPONENTES DEL EQUIPO
sudo lshw

## AGREGAR SSH KEY EN ARCH
pacman -S keychain
# append to ~/.bashrc the next command
export SSH_AUTH_SOCK=$XDG_RUNTIME_DIR/ssh-agent.socket

## REINICIAR INTERFAZ GRAFICA
ctrl + alt + f2
systemctl restart display-manager.service
