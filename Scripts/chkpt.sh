#!/bin/bash

echo "managing $1"

key=`curl -XPOST -sw 'HTTP_CODE=%{http_code}' --connect-timeout 50 -H 'Content-Type: application/json'  --max-time 50 -k 'https://'$1'/web_api/login' -d '{"user":"admin","password":"$ubiqube","continue-last-session":"true"}' | grep sid| cut -d"\"" -f4`

echo "key is $key"

echo "--------------------------------------------------"

#curl -XPOST -sw 'HTTP_CODE=%{http_code}' --connect-timeout 50 -H 'Content-Type: application/json' -H "X-chkp-sid:$key" --max-time 50 -k 'https://52.178.156.185:443/web_api/set-simple-gateway' -d '{"name":"hgu001","ip-address":"192.0.2.1","version":"","one-time-password":"","firewall":"false","vpn":"","application-control":"","ips":"","content-awareness":"","url-filtering":"","anti-virus":"","anti-bot":"","threat-emulation":"","threat-extraction":""}'

echo "--------------------------------------------------"

curl -XPOST -sw 'HTTP_CODE=%{http_code}' --connect-timeout 50 -H 'Content-Type: application/json' -H "X-chkp-sid:$key" --max-time 50 -k 'https://'$1'/web_api/show-simple-gateways' -d'{"details-level":"full"}'
#curl -XPOST -sw 'HTTP_CODE=%{http_code}' --connect-timeout 50 -H 'Content-Type: application/json' -H "X-chkp-sid:$key" --max-time 50 -k 'https://52.178.156.185:443/web_api/show-simple-gateway' -d'{"name":"hgu001"}'
#curl -XPOST -sw 'HTTP_CODE=%{http_code}' --connect-timeout 50 -H 'Content-Type: application/json' -H "X-chkp-sid:$key" --max-time 50 -k 'https://52.178.156.185:443/web_api/show-services-tcp' -d'{"details-level":"standard", "limit":"500"}'
#curl -XPOST -sw 'HTTP_CODE=%{http_code}' --connect-timeout 50 -H 'Content-Type: application/json' -H "X-chkp-sid:$key" --max-time 50 -k 'https://52.178.156.185:443/web_api/set-service-tcp' -d'{"name":"FW1_ela", "port":"9999"}'
#curl -XPOST -sw 'HTTP_CODE=%{http_code}' --connect-timeout 50 -H 'Content-Type: application/json' -H "X-chkp-sid:$key" --max-time 50 -k 'https://52.178.156.185:443/web_api/show-hosts' -d'{"details-level":"full"}'
