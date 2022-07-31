#!/bin/sh
#This script requires all files to be in the root directory.
#This script does not clean up after itself. Any files it uses or downloads in root are not deleted. Feel free to delete them after it executes.

#Apply ucm fixes and disable hdmi audio
sudo cp -rf 50-x205ta.conf /etc/modprobe.d #This disables hdmi audio. remove the blacklist from this file if you want to test if it works
sudo rm -rf /usr/share/alsa/ucm/chtrt5645/{HiFi,chtrt5645}.conf
sudo mkdir -p /usr/share/alsa/ucm/chtrt5645
sudo wget https://raw.githubusercontent.com/harryharryharry/x205ta-iso2usb-files/master/HiFi.conf -O /usr/share/alsa/ucm/chtrt5645/HiFi.conf
sudo wget https://raw.githubusercontent.com/plbossart/UCM/master/chtrt5645/chtrt5645.conf -O /usr/share/alsa/ucm/chtrt5645/chtrt5645.conf
git clone https://github.com/plbossart/UCM.git
sudo cp -rf /UCM/chtrt5645 /usr/share/alsa/ucm

#Fix alsa-base so the correct sound driver loads
if grep -q "options snd-intel-dspcfg dsp_driver=2" "/etc/modprobe.d/alsa-base.conf" ; then
	echo "Option already set in alsa-base. Skipping." ;
else
	echo "options snd-intel-dspcfg dsp_driver=2" | sudo tee -a /etc/modprobe.d/alsa-base.conf ;
fi

#Fix pulseaudio so that the default port when started is set as speaker
if grep -q "set-sink-port\+[[:space:]]\+0\+[[:space:]]\+\[Out\]\+[[:space:]]\+Speaker" "/etc/pulse/default.pa" ; then
	echo "Default sink port set to speaker already. Skipping." ;
else
	echo "set-sink-port 0 [Out] Speaker" | sudo tee -a /etc/pulse/default.pa ;
fi

#Auto detect headphone insertion/removal and change audio port accordingly

#Currently does not work as headphone events aren't fired on insert. If someone can make acpi detect this, then uncomment this section to test.
#sudo chmod +x headphone-plug.sh
#sudo chmod +x headphone-unplug.sh
#sudo cp -rf headphone-plug.sh /etc/acpi
#sudo cp -rf headphone-unplug.sh /etc/acpi
#sudo cp -rf headphone-plug /etc/acpi/events
#sudo cp -rf headphone-unplug /etc/acpi/events
#sudo service acpid restart

echo "Alsa fixes have completed. Reboot for changes to take effect."
