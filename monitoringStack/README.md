# loki
This is a test setup of a potential monitoring stack for the new DBC Site.
It uses Fluent Bit sidecar on the NGINX pod -> Loki -> Grafana. For storage this test instance it uses MinIO to simulate S3 storage

## Components
### FluentBit
Add the code from the sidecar.yaml to the nginx deployment

Ensure that you have the following lines in your nginx.conf

    access_log /logs/access.log main; #Sent to a mounted logs volume so it can go to fluent bit

    log_format  main  '$remote_addr - $remote_user [$time_local] "$request" '
                      '$status $body_bytes_sent "$http_referer" '
                      '"$http_user_agent" $http_x_forwarded_for $upstream_cache_status $request_time';

Finally add the _fluentbit-configmap.yaml_ to OpenShift. Ensure you have the LOKI_GATEWAY_URL set correctly (You should be able to get this from Networking -> Services)



### loki
To start I followed the instructions here to setup loki: https://grafana.com/docs/loki/latest/setup/install/helm/install-scalable/. Use the values.yaml file in the loki folder in this repo as I had to make some changes.

You can see the full values.yaml file here if you need: https://github.com/grafana/loki/blob/main/production/helm/loki/values.yaml

Once you are ready to install, login to OC and then from the loki folder, run:

`helm upgrade --install --values values.yaml loki grafana/loki`

### grafana
https://github.com/grafana/helm-charts/tree/main/charts/grafana 

`helm upgrade --install --values values.yaml grafana grafana/grafana`

After I got it installed I created a route manually to be able to see the UI without doing port forwarding. The credentials are stored in a secret in OpenShift

Used this dashboard as the source
https://grafana.com/grafana/dashboards/13740-loki-v2-web-analytics-dashboard-for-nginx/
To use it I would suggest:
1. Setup the datasource in Grafana. Select Loki and use the gateway service as the hostname.
1. Use the dashboard.json file in the grafana folder
1. Pull that into Grafana, but you will need to update the datasource
    1. Get the guid by going to the data source and pulling it from the URL
    1. Find and replace the old guid
    1. Save Changes
1. Dashboard should now work.


## To-Do
1. See how well the system works under load
1. Try running multiple ngix pods at once
1. Figure out how to handle large log files, will need to delete the logs somehow. Might be best to investigate using something like promtrail with syslog so logs aren't actually stored in the pod itself.


### goaccess notes
Not currently planning to use this, but could be used as a backup where we move all log files to an s3 bucket on a daily basis and then have goaccess pull those logs on a daily and/or weekly basis so that people get insight into site stats.
1. Need to use kill 1 command in the goaccess terminal to get it to regenerate
1. From command line run something like: `oc cp image-caching-5f476f49c5-gqmgs:/logs/index.html goaccess.html` to pull the html file to your desktop for review.