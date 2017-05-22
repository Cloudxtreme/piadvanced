#!/bin/sh
## HASS
NAMEOFAPP="hass"
WHATITDOES="Home Assistant is an open-source home automation platform"

## Current User
CURRENTUSER="$(whoami)"

## Dependencies Check
sudo bash /etc/piadvanced/dependencies/dep-whiptail.sh

## Variables
source /etc/piadvanced/install/firewall.conf
source /etc/piadvanced/install/variables.conf
source /etc/piadvanced/install/userchange.conf

{ if 
(whiptail --title "$NAMEOFAPP" --yes-button "Skip" --no-button "Proceed" --yesno "Do you want to setup $NAMEOFAPP? $WHATITDOES" 8 78) 
then
echo "$CURRENTUSER Declined $NAMEOFAPP" | sudo tee --append /etc/piadvanced/install/installationlog.txt
echo ""$NAMEOFAPP"install=no" | sudo tee --append /etc/piadvanced/install/variables.conf
else
echo "$CURRENTUSER Accepted $NAMEOFAPP" | sudo tee --append /etc/piadvanced/install/installationlog.txt
echo ""$NAMEOFAPP"install=yes" | sudo tee --append /etc/piadvanced/install/variables.conf

## Below here is the magic.

## Clone repo
sudo git clone https://github.com/home-assistant/fabric-home-assistant.git /etc/piadvanced/fabric-home-assistant/

## go to directory
cd /etc/piadvanced/fabric-home-assistant

## remove reboot
sudo sed -i "s/reboot/#reboot/" /etc/piadvanced/fabric-home-assistant/fabfile.py

## do the things
fab deploy_novenv -H localhost 2>&1 | sudo tee installation_report.txt

## firewall rule
sudo echo ""$NAMEOFAPP"firewall=yes" | sudo tee --append /etc/piadvanced/install/firewall.conf

## End of install
fi }

## Unset Temporary Variables
unset NAMEOFAPP
unset CURRENTUSER
unset WHATITDOES

## Module Comments
