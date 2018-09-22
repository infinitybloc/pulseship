# pulseship
Shipping logs and metrics to **PULSE**

```SHIPPER_NAME``` is a highest aggregation level name that your logs and metrics will show up as.
Yeah host that the scripts ```pulseship_setup.sh``` and ```pulseship_start.sh``` are run on, will have it's separate logs and metrics under the ```SHIPPER_NAME```.

To access pulse, please use the following link: https://17f00a9296e0446887c18036f54e3f0d.us-west1.gcp.cloud.es.io:9243.

We'll add other links as the loadbalacer comes online.

Please obtain your login/password paris from the network or chain admin, they also might be published in the public instructinos for joining the chain.

Here are all the simple steps you need to do to join the chain. Please edit ```SHIPPER_CHAIN``` and ```SHIPPER_NET``` according to the instructions that you've received with login/password info, as data access athorization is linked to the account (you won't be able to see your data if you're sending to the wrong index for the wrong chain and net).

* edit ```pulseship.conf```

```
export SHIPPER_NAME="infinitybloc"
export SHIPPER_CHAIN="telos"
export SHIPPER_NET="testnet"
export LOGS_PATH="/var/log/telos/*.log" # this is an example, you can change it to the pattern of your logs
```

* Start the pulse local modules, they'll run as services in the background:

```
./pulseship_setup.sh
./pulseship_start.sh
```

That should be it! :) 

* Give it about 10s to start streaming and after that you should be able to see it at the pulse logs and metrics at the link: https://17f00a9296e0446887c18036f54e3f0d.us-west1.gcp.cloud.es.io:9243

This is kept for now as generic as possible on purpose. To use **PULSE** you can use any regular Kibana techniques, with more info found here: https://www.elastic.co/products/kibana

Top level dashboards that you can start using immediately are: 

```
Kibana->Dashboard->{pulse} metric overview dash
Kibana->Dashboard->{pulse} logs overview dash
```

Any monitoring projects is always continuous, we'll be adding more visualizations, dashboards, machine learning capabilities and other features. This "basic" access to elasticsearch and kibana and all the data there will always be there however to conitnue to be useful at the "lowest" level.

If you don't see your logs and/or metrics on the **PULSE** link above, you can quickly check locally on your host:

### Maintenace
* Pulse components write some logs to the following files that you might want to delete periodically or do local log rotation on:
```
/var/log/filebeat/*
/var/log/metricbeat/*
```

### DEBUG

* If you don't see your shipper or host on the dashboard, you can see whether there are any issues in the flogs below:
```
tail -f /var/log/filebeat/filebeat
tail -f /var/log/metricbeat/metricbeat
```
* If there are some issues and you'd line to reset your system here is a sequece of scripts that you can run:
```
$ ../pulseship/pulship_stop.sh # stop shipping data to pulse
$ ../pulseship/pulship_reset.sh # reset the configuration, you'll need to set your config again as above
$ ../pulseship/pulship_start.sh # start shipping with new configs
```
* To completely remove the components from your system run:
```
$ ../pulseship/pulship_clean.sh
```
The clean install of the components can be done after clean.

* If there are 2 or more systems with the same shipper and hostname, the logs will be "merged" in the dashboard. Make sure that at elast the hostame is different for each system.

Please see the sysadmin or forum for your chain to check for maping of tags to **PULSE** accounts. For example if you were given an account of *telos-bp-ops*, you'll have to set tags to *telos* and *testnet.telos* (just and example, refer to the instuctions).

Please free to open an issue, this is in alpha, so we'll definitely jump on it! :)










