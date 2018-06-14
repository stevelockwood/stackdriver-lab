#!/bin/bash
  if [ ! -f /initialized.txt ]; then
    # install apache
    apt-get update
    apt-get install -y apache2

    # install logging agent
    curl -sSO https://dl.google.com/cloudagents/install-logging-agent.sh
    bash install-logging-agent.sh

    # install monitoring agent
    curl -sSO https://dl.google.com/cloudagents/install-monitoring-agent.sh
    bash install-monitoring-agent.sh

    # create file showing setup
    touch /initialized.txt
fi
