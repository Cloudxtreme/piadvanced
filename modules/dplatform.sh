#!/bin/sh
## Dplatform

## Variables
source /etc/piadvanced/install/firewall.conf
source /etc/piadvanced/install/variables.conf
source /etc/piadvanced/install/userchange.conf

{ if (whiptail --yes-button "Skip" --no-button "Proceed" --yesno "Do you want to install and use the Dplatform installer?" 8 78) then
echo "User Declined Dplatform"
else
sudo wget https://raw.githubusercontent.com/DFabric/DPlatform-ShellCore/master/init.sh -P /etc/piadvanced/installscripts/dplatform/
sudo bash /etc/piadvanced/installscripts/dplatform/init.sh
whiptail --msgbox "Any programs installed via Dplatform need firewall rules." 20 70 1
fi }
