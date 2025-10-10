#!/bin/bash

## First do the next line for each conection needed to automate this script
# ssh-copy-id user@domain
## Run the SHUTDOWN_CMD without needing of enter password
# sudo visudo
## Comment the next line
# truenas_admin ALL=(ALL) ALL
## Add after it the next line
# truenas_admin ALL=(ALL) NOPASSWD: /sbin/shutdown

## HOW TO USE:
## To power on the server
# nas
## To power off the server
# nas off

POWER_ON_USER="salva"
POWER_ON_HOST="192.168.0.41"

POWER_OFF_USER="truenas_admin"
POWER_OFF_HOST="192.168.0.40"

MACHINE_IP_TO_PING="192.168.0.40"

SHUTDOWN_CMD="sudo shutdown -h now"

trap 'tput cnorm; echo' EXIT # Unhide the cursor when the script finishes
tput civis # Hide the cursor


if ping -c 1 $MACHINE_IP_TO_PING &> /dev/null; then
    case "$1" in
        off)
            ssh $POWER_OFF_USER@$POWER_OFF_HOST \'$SHUTDOWN_CMD\'
            ;;
        *)
            echo -e "\n-> Server on line at                    \n-> https://${MACHINE_IP_TO_PING}"
            ;;
    esac
else
    ssh $POWER_ON_USER@$POWER_ON_HOST 'python power_btn_server.py'
    contador=0
    while ! ping -c 1 $MACHINE_IP_TO_PING &> /dev/null; do
        ((contador++))
        echo -ne "-> Turning on the server (${contador})\r"
        sleep 1
    done
    echo -e "\n-> Server on line at                    \n-> https://${MACHINE_IP_TO_PING}"
fi

exit 0
