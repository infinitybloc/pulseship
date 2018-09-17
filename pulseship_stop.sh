#!/usr/bin/env bash
[ $(whoami) != "root" ] && SUDO=sudo

echo "Stopping metricbeat..."
${SUDO} service metricbeat stop

echo "Stopping filebeat..."
${SUDO} service filebeat stop
