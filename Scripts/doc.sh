#!/bin/bash
doc=`docker ps --format "{{.Names}}"`
echo "$doc"
echo "-------------------------------"
read -p "Which container would you like to connect to (nickname is ok too) ? " -a answer
echo "-------------------------------"
echo "connecting to $answer"
echo "-------------------------------"
case "$answer" in
 sms) docker exec -it quickstart_msa_sms_1 bash;;
 api) docker exec -it quickstart_msa_api_1 bash;;
 dev) docker exec -it quickstart_msa_dev_1 bash;;
 front) docker exec -it quickstart_msa_front_1 bash;;
 ui) docker exec -it quickstart_msa_ui_1 bash;;
 bud) docker exec -it quickstart_msa_bud_1 bash;;
 db) docker exec -it quickstart_db_1 bash;;
 es) docker exec -it quickstart_msa_es_1 bash;;
 linux) docker exec -it quickstart_linux_me_1 bash;;
 me) docker exec -it quickstart_linux_me_1 bash;;
 camunda) docker exec -it quickstart_camunda_1 bash;;
 exit) exit;;
 *) docker exec -it $answer bash;;
esac
