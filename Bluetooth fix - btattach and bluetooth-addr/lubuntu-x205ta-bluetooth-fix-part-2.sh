#!/bin/sh
sudo systemctl enable bluetooth-addr.service
sudo systemctl start bluetooth-addr.service
sudo systemctl enable btattach --now
echo "Bluetooth fix finished. Restarting bluetooth"
sudo systemctl restart bluetooth
echo "If bluetooth is not working, a reboot is required for the fix to take effect"
