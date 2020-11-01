#!/bin/bash

key=`curl --insecure -H 'Content-Type: application/json' -XPOST https://127.0.0.1/ubi-api-rest/auth/token -d '{"username":"ncroot", "password":"ubiqube"}' | cut -d'"' -f4`

echo "key is $key"

echo "----------------GET WF Variables--------------------"
curl --insecure -H 'Accept: application/json' -H'Content-Type: application/json' -H "Authorization: Bearer $key" -XGET https://127.0.0.1/ubi-api-rest/orchestration/service/variables/75 | python -m json.tool
echo "----------------Execute Workflow--------------------"
curl --insecure -H 'Accept: application/json' -H'Content-Type: application/json' -H "Authorization: Bearer $key" -XPOST https://127.0.0.1/ubi-api-rest/orchestration/process/execute/BLRA6/75?processName=Process%2FConstruction_of_equipment__Rollout_%2FUpdate -d '{"construction_name":"ER-A204","additional_device_name":"BLR125","additional_device_ip":"10.101.1.1","network_prefix":"24","adjacent_cr_name":"CR-A","adjacent_cr_ip":"127.0.0.1","id":"1","dst_port":"20001"}'| python -m json.tool
echo "--------------Get Workflow Status-------------------"
curl --insecure -H 'Accept: application/json' -H'Content-Type: application/json' -H "Authorization: Bearer $key" -XGET https://127.0.0.1/ubi-api-rest/orchestration/v1/service/process-instance/75 | python -m json.tool
curl --insecure -H 'Accept: application/json' -H "Authorization: Bearer $key" -XGET https://127.0.0.1/ubi-api-rest/orchestration/v1/last-processes?ubiqubeId=BLRA6\&timeRange=50\&maxEntries=1 | python -m json.tool
echo "-------------------Get MS List----------------------"
curl --insecure -H 'Accept: application/json' -H'Content-Type: application/json' -H "Authorization: Bearer $key" -XGET https://127.0.0.1/ubi-api-rest/ordercommand/objects/125| python -m json.tool
echo "----------------list MS instances-------------------"
curl --insecure -H 'Accept: application/json' -H'Content-Type: application/json' -H "Authorization: Bearer $key" -XGET https://127.0.0.1/ubi-api-rest/ordercommand/objects/125/vpn_conf| python -m json.tool
echo "--------Get  variables from an MS isntance----------"
curl --insecure -H 'Accept: application/json' -H'Content-Type: application/json' -H "Authorization: Bearer $key" -XGET https://127.0.0.1/ubi-api-rest/ordercommand/objects/125/vpn_conf/ce_vpn1_vpn_conf| python -m json.tool
echo "-----------------Trigger IMPORT---------------------"
curl --insecure -H 'Accept: application/json' -H'Content-Type: application/json' -H "Authorization: Bearer $key" -XPOST https://127.0.0.1/ubi-api-rest/ordercommand/execute/125/IMPORT -d '{"VLAN_Database":"0"}' | python -m json.tool
echo "-----------------Trigger UPDATE---------------------"
curl --insecure -H 'Accept: application/json' -H'Content-Type: application/json' -H "Authorization: Bearer $key" -XPOST https://127.0.0.1/ubi-api-rest/ordercommand/execute/125/UPDATE -d '{"basic_conf": {"BLR125": {"object_id": "BLR125","device_ip": "10.101.1.2","prefix": "24","neighbor": "127.0.0.2"}}}' | python -m json.tool

echo "--------------------------------------------------"
