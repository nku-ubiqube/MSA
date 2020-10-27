#!/bin/bash

key=`curl --insecure -H 'Content-Type: application/json' -XPOST https://127.0.0.1/ubi-api-rest/auth/token -d '{"username":"ncroot", "password":"ubiqube"}' | cut -d'"' -f4`

echo "key is $key"

echo "--------------------------------------------------"

#curl --insecure -H 'Accept: application/json' -H "Authorization: Bearer $key" -XGET https://127.0.0.1/ubi-api-rest/lookup/devices | python -m json.tool

#curl --insecure -H 'Accept: application/json' -H "Authorization: Bearer $key" -XGET https://127.0.0.1/ubi-api-rest/elastic-search/v1/index-settings | python -m json.tool

#curl --insecure -H 'Accept: application/json' -H "Authorization: Bearer $key" -XPOST https://127.0.0.1/ubi-api-rest/elastic-search/v1/logs | python -m json.tool

#curl --insecure -H 'Accept: application/json' -H "Authorization: Bearer $key" -XGET https://127.0.0.1/ubi-api-rest/orchestration/v1/services -d '{"ubiqubeId":"BLRA6"}' | python -m json.tool

#curl --insecure -H 'Accept: application/json' -H "Authorization: Bearer $key" -XGET https://127.0.0.1/ubi-api-rest/orchestration/BLRA6/service/instance | python -m json.tool

curl --insecure -H 'Accept: application/json' -H "Authorization: Bearer $key" -XGET https://127.0.0.1/ubi-api-rest/orchestration/v1/BLRA6/workflow/details?serviceName=Process/Construction_of_equipment__Rollout_/Construction_of_equipment__Rollout_.xml | python -m json.tool
