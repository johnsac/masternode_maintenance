#!/bin/bash
# install.sh
# Installs smartnode on Ubuntu 16.04 LTS x64
# ATTENTION: The anti-ddos part will disable http, https and dns ports.
# crontab -e 

if [ "$(whoami)" != "root" ]; then
  echo "Script must be run as user: root"
  exit -1
fi


# example: su - smartadmin -c "smartcashd"
# example: su - adnuser -c "~/adn/adnd --daemon"
# example: su - gobyteadmin -c "~/gobyte/src/gobyted -daemon"


printf "Name of coin folder:"
read _coinName


printf "Exact command for root user to start the node:"
read _startNode




# Create a cronjob for making sure masternode runs after reboot
if ! crontab -l | grep "@reboot ${_startNode}"; then
  (crontab -l ; echo "@reboot ${_startNode}") | crontab -
fi



# Create a cronjob for clearing the log file
if ! crontab -l | grep "/bin/date > ~/.${_coinName}/debug.log"; then
  (crontab -l ; echo "0 0 */2 * * /bin/date > ~/.${_coinName}/debug.log") | crontab -
fi

