#!/usr/bin/env bash
[ $(whoami) != "root" ] && SUDO=sudo

echo "Resetting metricbeat,filebeat..."
${SUDO} ./pulseship_stop.sh

${SUDO} cp metricbeat.pulseship.yml /etc/metricbeat/metricbeat.yml
${SUDO} cp filebeat.pulseship.yml /etc/filebeat/filebeat.yml
