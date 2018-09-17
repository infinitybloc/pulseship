#!/usr/bin/env bash
[ $(whoami) != "root" ] && SUDO=sudo

echo "Setting up metricbeat..."
cd /tmp
curl -L -O https://artifacts.elastic.co/downloads/beats/metricbeat/metricbeat-6.4.0-amd64.deb
${SUDO} dpkg -i metricbeat-6.4.0-amd64.deb
${SUDO} ln -s /usr/share/metricbeat/modules.d/ /etc/metricbeat/modules.d
${SUDO} metricbeat modules enable system

echo "Setting up filebeat..."
cd /tmp
curl -L -O https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-6.4.0-amd64.deb
${SUDO} dpkg -i filebeat-6.4.0-amd64.deb


