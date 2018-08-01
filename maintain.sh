#!/bin/bash
# Intended for Ubuntu 16.04 LTS x64

if [ "$(whoami)" != "root" ]; then
  echo "Script must be run as user: root"
  exit -1
fi


# example: su - smartadmin -c "smartcashd"
# example: su - adnuser -c "~/adn/adnd --daemon"
# example: su - gobyteadmin -c "~/gobyte/src/gobyted -daemon"


printf "Name of coin folder: "
read _coinName

printf "Example: su - smartadmin -c "smartcashd" "
printf "Example: su - adnuser -c "~/adn/adnd --daemon" "
printf "Example: su - gobyteadmin -c "~/gobyte/src/gobyted -daemon" "
printf "Exact command for root user to start the node (see examples above): "
read _startNode




# Create a cronjob for making sure masternode runs after reboot
if ! crontab -l | grep "@reboot ${_startNode}"; then
  (crontab -l ; echo "@reboot ${_startNode}") | crontab -
fi



# Create a cronjob for clearing the log file every two hours
if ! crontab -l | grep "/bin/date > ~/.${_coinName}/debug.log"; then
  (crontab -l ; echo "0 0 */2 * * /bin/date > ~/.${_coinName}/debug.log") | crontab -
fi

