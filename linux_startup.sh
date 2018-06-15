#!/bin/bash
  if [ ! -f /initialized.txt ]; then
    # install apache, git
    apt-get update
    apt-get install -y apache2 git

    # install logging agent
    curl -sSO https://dl.google.com/cloudagents/install-logging-agent.sh
    bash install-logging-agent.sh

    # install monitoring agent
    curl -sSO https://dl.google.com/cloudagents/install-monitoring-agent.sh
    bash install-monitoring-agent.sh

    # clone repo
    cd /
    git clone https://github.com/jwdavis/stackdriver-lab.git
    cd /stackdriver-lab

    # update apache config
    cp /var/www/html/index.html /var/www/html/secure.html
    cp apache2.conf /etc/apache2/apache2.conf
    /etc/init.d/apache2 reload

    # create file showing setup
    touch /initialized.txt
fi
