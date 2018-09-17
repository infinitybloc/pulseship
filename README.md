# pulseship
Shipping logs and metrics to PULSE

* edit ```pulseship.conf```

```
# example of vars that need to be changed
# shipper is a name under which all the metrics and logs
# will show up.
# Use the same shipper name for all the hosts
# you're deploying pulseship on
# Recommended to put the same name as what shows
# up on the monitor
export SHIPPER_NAME="infinitybloc"
export SHIPPER_CHAIN="telos"
export SHIPPER_NET="testnet"
export LOGS_PATH="/var/log/telos/*.log"
```
* start the beats (metricbeat, filebeat), they'll run as services in the background

```
./pulseship_setup.sh
./pulseship_start.sh
```

* to check/debug
```
tail -f /var/log/filebeat/filebeat
tail -f /var/log/filebeat/metricbeat
```


* If you have nodeos running already, you can skipt this step

```
# run the nodeos to point the to LOGS_PATH or visa versa
# /opt/eosio/bin/nodeosd.sh --enable-stale-production >> /var/log/telos/telos.log 2>&1
nodeos ... >> /var/log/telos/telos.log 2>&1

* get pulse user and password from the chain admin to access the dashboards
# Access kibana page https://17f00a9296e0446887c18036f54e3f0d.us-west1.gcp.cloud.es.io:9243

# logs example
kibana->discover->search < "beat.name: infinitybloc"

# metrics example
kibana->dasboard->search < "{pulse} metrics overview dash"
```

* That's it!

Additional actions:

* start script will enable the service to run from startup
* ```./pulseship_stop.sh```
* ```./pulseship_reset.sh``` - will reset the config
* ```./pulseship_clean.sh```


