#!/bin/sh
"$WORK_DIR=$PWD"
sudo cp "bluetooth-addr.service" "/etc/systemd/system"
sudo chmod +x lubuntu-x205ta-bluetooth-fix-part-1.sh
sudo chmod +x lubuntu-x205ta-bluetooth-fix-part-2.sh
sudo wget https://raw.githubusercontent.com/harryharryharry/x205ta-iso2usb-files/master/BCM43341B0.hcd -O /lib/firmware/brcm/BCM43341B0.hcd
hciconfig -a
cd / || return
echo "Attempting to change to working directory"
echo "Current working directory is ${PWD}"
sudo x-terminal-emulator -e "sudo ./lubuntu-x205ta-bluetooth-fix-part-1.sh"
cd / || exit
echo "Attempting to change to working directory"
echo "Current working directory is ${PWD}"
sudo ./lubuntu-x205ta-bluetooth-fix-part-2.sh
