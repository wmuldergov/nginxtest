# loki
This is a test setup of a potential monitoring stack for the new DBC Site.
It uses Fluent Bit sidecar on the NGINX pod -> Loki -> Grafana. For storage this test instance simply uses the filesystem

## Components
### FluentBit
Add the code from the sidecar.yaml to the nginx deployment

Ensure that you have the following lines in your nginx.conf

    access_log /logs/access.log main; #Sent to a mounted logs volume so it can go to fluent bit


    log_format  main  '$remote_addr - $remote_user [$time_local] "$request" '
                      '$status $body_bytes_sent "$http_referer" '
                      '"$http_user_agent" $http_x_forwarded_for $upstream_cache_status $request_time';

Finally add the fluentbit-configmap.yaml to OpenShift. LOKI_GATEWAY_URL

### loki
To start I followed the instructions here to setup loki: https://grafana.com/docs/loki/latest/setup/install/helm/install-monolithic/. Use the values.yaml file in the loki folder. NOTE: There is a bug when you install it where you need to remove the id's from the securityContext in the statefulset YAML.


You can see the full values.yaml file here if you need: https://github.com/grafana/loki/blob/main/production/helm/loki/values.yaml

`helm install --values values.yaml loki grafana/loki`

### grafana
https://github.com/grafana/helm-charts/tree/main/charts/grafana 

`helm install --values values.yaml grafana grafana/grafana`

After I got it installed I created a route to be able to see the UI without doing port forwarding. The credentials are stored in a secret.

Used this dashboard as the source
https://grafana.com/grafana/dashboards/13740-loki-v2-web-analytics-dashboard-for-nginx/

## To-Do
1. Test with s3 storage
1. Test scalable setup
1. Fix the bug with loki security context
1. See how well the system works under load
1. Try running multiple pods at once
