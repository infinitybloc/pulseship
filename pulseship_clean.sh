#!/usr/bin/env bash
[ $(whoami) != "root" ] && SUDO=sudo

echo "Cleaning metricbeat..."
${SUDO} service metricbeat stop
${SUDO} dpkg --purge metricbeat

echo "Cleaning filebeat..."
${SUDO} service filebeat stop
${SUDO} dpkg --purge filebeat


