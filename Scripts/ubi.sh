#!/bin/bash

key=`curl --insecure -H 'Content-Type: application/json' -XPOST https://127.0.0.1/ubi-api-rest/auth/token -d '{"username":"ncroot", "password":"ubiqube"}' | cut -d'"' -f4`

echo "key is $key"
echo "--------------------------------------------------"
#Get Managed Entity Assets
#curl --insecure -H 'Accept: application/json' -H "Authorization: Bearer $key" -XGET https://127.0.0.1/ubi-api-rest/assetManagement/v1/device-asset/device/ref/BLR125
#Execute Workflow process
#curl --insecure -H 'Accept: application/json' -H "Authorization: Bearer $key" -XPOST https://127.0.0.1/ubi-api-rest/orchestration/process/execute/BLRA6/64?processName=Process%2FVPN_Activation%2FAllocate_VLAN-ID -d '{"vpn_name":"VPN6789","ce_list":[{"id":"BLR133"}],"vlan_id":"10","er_list":[{"id":"BLR135"}],"vpn_id":"45778","sla":"SLA1","bandwidth":"500"}'  | python -m json.tool
echo "--------------------------------------------------"
#curl --insecure -H 'Accept: application/json' -H "Authorization: Bearer $key" -XGET https://127.0.0.1/ubi-api-rest/orchestration/v1/service/process-instance/454
echo "--------------------------------------------------"
#curl --insecure -H 'Accept: application/json' -H "Authorization: Bearer $key" -XGET https://127.0.0.1/ubi-api-rest/orchestration/v1/services/75/service-variables

echo "--------------------------------------------------"

#curl --insecure -H 'Accept: application/json' -H "Authorization: Bearer $key" -XGET https://127.0.0.1/ubi-api-rest/lookup/devices | python -m json.tool

#curl --insecure -H 'Accept: application/json' -H "Authorization: Bearer $key" -XGET https://127.0.0.1/ubi-api-rest/elastic-search/v1/index-settings | python -m json.tool

#curl --insecure -H 'Accept: application/json' -H "Authorization: Bearer $key" -XPOST https://127.0.0.1/ubi-api-rest/elastic-search/v1/logs | python -m json.tool

#curl --insecure -H 'Accept: application/json' -H "Authorization: Bearer $key" -XGET https://127.0.0.1/ubi-api-rest/orchestration/v1/services -d '{"ubiqubeId":"BLRA6"}' | python -m json.tool

#curl --insecure -H 'Accept: application/json' -H "Authorization: Bearer $key" -XGET https://127.0.0.1/ubi-api-rest/orchestration/BLRA6/service/instance | python -m json.tool

#curl --insecure -H 'Accept: application/json' -H "Authorization: Bearer $key" -XGET https://127.0.0.1/ubi-api-rest/orchestration/v1/BLRA6/workflow/details?serviceName=Process/Construction_of_equipment__Rollout_/Construction_of_equipment__Rollout_.xml | python -m json.tool

#curl --insecure -H 'Accept: application/json' -H "Authorization: Bearer $key" -XGET https://127.0.0.1/ubi-api-rest/orchestration/v1/BLRA6/workflow/details?serviceName=Process%2FConstruction_of_equipment__Rollout_%2FConstruction_of_equipment__Rollout_ | python -m json.tool

#curl --insecure -H 'Accept: application/json' -H "Authorization: Bearer $key" -XGET https://127.0.0.1/ubi-api-rest/orchestration/BLRA6/service/instance | python -m json.tool

# curl --insecure -H 'Accept: application/json' -H "Authorization: Bearer $key" -XGET https://127.0.0.1/ubi-api-rest/orchestration/BLRA6/service/instance/66 | python -m json.tool

curl --insecure -H 'Accept: application/json' -H "Authorization: Bearer $key" -XGET https://127.0.0.1/ubi-api-rest/orchestration/service/variables/66 | python -m json.tool
