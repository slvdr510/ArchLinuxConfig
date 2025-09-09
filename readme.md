# Comandos que he ido usando en Arch Linux

---

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
