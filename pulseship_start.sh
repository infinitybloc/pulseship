#!/usr/bin/env bash
[ $(whoami) != "root" ] && SUDO=sudo

source ./pulseship.conf

export SHIPPER_TAGS="[\"${SHIPPER_CHAIN}\",\"${SHIPPER_NET}.${SHIPPER_CHAIN}\"]"
echo "CLOUD_ID=${CLOUD_ID}"
echo "CLOUD_AUTH=${CLOUD_AUTH}"
echo "SHIPPER_NAME=${SHIPPER_NAME}"
echo "SHIPPER_TAGS=${SHIPPER_TAGS}"
echo "LOGS_PATH=${LOGS_PATH}"

#
# METRICBEAT
#
echo "Configuring metricbeat..."
YAML_FILE=/etc/metricbeat/metricbeat.yml
${SUDO} cp ./metricbeat.pulseship.yml ${YAML_FILE}
export CLOUD_ID; ${SUDO} sed -i.bak "s/#cloud.id:/cloud.id: ${CLOUD_ID}/g" ${YAML_FILE}
export CLOUD_AUTH; ${SUDO} sed -i.bak "s/#cloud.auth:/cloud.auth: ${CLOUD_AUTH}/g" ${YAML_FILE}
export SHIPPER_NAME; ${SUDO} sed -i.bak "s/#name:/name: ${SHIPPER_NAME}/g" ${YAML_FILE}
export SHIPPER_TAGS; ${SUDO} sed -i.bak "s/#tags: \[\"service-X\", \"web-tier\"\]/tags: ${SHIPPER_TAGS}/g" ${YAML_FILE}

# output.elasticsearch.index
export SHIPPER_CHAIN; export SHIPPER_NET; ${SUDO} sed -i.bak "s/#output.elasticsearch.index:/output.elasticsearch.index: \"metricbeat-${SHIPPER_CHAIN}-${SHIPPER_NET}.${SHIPPER_CHAIN}-%{+yyyy.MM.dd}\"/g" ${YAML_FILE}
# setup.template.name
export SHIPPER_CHAIN; export SHIPPER_NET; ${SUDO} sed -i.bak "s/#setup.template.name:/setup.template.name: \"metricbeat-${SHIPPER_CHAIN}\"/g" ${YAML_FILE}
# setup.template.pattern
export SHIPPER_CHAIN; export SHIPPER_NET; ${SUDO} sed -i.bak "s/#setup.template.pattern:/setup.template.pattern: \"metricbeat-${SHIPPER_CHAIN}-*\"/g" ${YAML_FILE}
# setup.dashboards.index
export SHIPPER_CHAIN; export SHIPPER_NET; ${SUDO} sed -i.bak "s/#setup.dashboards.index:/setup.dashboards.index: \"metricbeat-${SHIPPER_CHAIN}-*\"/g" ${YAML_FILE}

echo "Enabling metricbeat at startup..."
${SUDO} update-rc.d metricbeat defaults
#${SUDO} service --status-all

echo "Starting metricbeat..."
${SUDO} service metricbeat start

#
# FILEBEAT
#
YAML_FILE=/etc/filebeat/filebeat.yml
echo "Configuring filebeat..."
${SUDO} cp ./filebeat.pulseship.yml ${YAML_FILE}
export CLOUD_ID; ${SUDO} sed -i.bak "s/#cloud.id:/cloud.id: ${CLOUD_ID}/g" ${YAML_FILE}
export CLOUD_AUTH; ${SUDO} sed -i.bak "s/#cloud.auth:/cloud.auth: ${CLOUD_AUTH}/g" ${YAML_FILE}
export SHIPPER_NAME; ${SUDO} sed -i.bak "s/#name:/name: ${SHIPPER_NAME}/g" ${YAML_FILE}
export SHIPPER_TAGS; ${SUDO} sed -i.bak "s/#tags: \[\"service-X\", \"web-tier\"\]/tags: ${SHIPPER_TAGS}/g" ${YAML_FILE}
export LP=$(echo "${LOGS_PATH}" | sed -e 's/[\/&]/\\&/g'); ${SUDO} sed -i.bak s/'\/var\/log\/\*.log'/${LP}/g ${YAML_FILE}

# output.elasticsearch.index
export SHIPPER_CHAIN; export SHIPPER_NET; ${SUDO} sed -i.bak "s/#output.elasticsearch.index:/output.elasticsearch.index: \"filebeat-${SHIPPER_CHAIN}-${SHIPPER_NET}.${SHIPPER_CHAIN}-%{+yyyy.MM.dd}\"/g" ${YAML_FILE}
# setup.template.name
export SHIPPER_CHAIN; export SHIPPER_NET; ${SUDO} sed -i.bak "s/#setup.template.name:/setup.template.name: \"filebeat-${SHIPPER_CHAIN}\"/g" ${YAML_FILE}
# setup.template.pattern
export SHIPPER_CHAIN; export SHIPPER_NET; ${SUDO} sed -i.bak "s/#setup.template.pattern:/setup.template.pattern: \"filebeat-${SHIPPER_CHAIN}-*\"/g" ${YAML_FILE}
# setup.dashboards.index
export SHIPPER_CHAIN; export SHIPPER_NET; ${SUDO} sed -i.bak "s/#setup.dashboards.index:/setup.dashboards.index: \"filebeat-${SHIPPER_CHAIN}-*\"/g" ${YAML_FILE}

echo "Enabling filebeat at startup..."
${SUDO} update-rc.d filebeat defaults
#${SUDO} service --status-all

echo "Starting filebeat..."
${SUDO} service filebeat start
