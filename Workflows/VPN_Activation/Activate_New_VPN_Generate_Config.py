from msa_sdk.variables import Variables
from msa_sdk.msa_api import MSA_API
from msa_sdk.order import Order
from msa_sdk import util

dev_var = Variables()
dev_var.add('vpn_name', var_type='String')
dev_var.add('ce_list.0.id', var_type='Device')
dev_var.add('er_list.0.id', var_type='Device')
dev_var.add('vlan_id', var_type='Integer')
dev_var.add('vpn_id', var_type='String')
dev_var.add('sla', var_type='String')
dev_var.add('bandwidth', var_type='Integer')
context = Variables.task_call(dev_var)

process_id = context['SERVICEINSTANCEID']

ce_list = context['ce_list']
er_list = context['er_list']

if len(ce_list) != len(er_list):
  ret = MSA_API.process_content('FAILED', f'{ce_list} and {er_list} do not contain the same number of devices ', context, True)
  print(ret)
  
for i in range(len(ce_list)):
  # extract the database ID for ce ID
  devicelongid=ce_list[i]['id'][-3:]
  util.log_to_process_file(process_id, devicelongid)
  object_id = "ce_"+context['vpn_id']+"_vpn_conf"
  # build the Microservice JSON params for the CREATE
  micro_service_vars_array = {"object_id": object_id,
                              "router": ce_list[i]['id'],
                              "vlan_id": context['vlan_id'],
                              "vpn_id": context['vpn_id'],
                              "sla": context['sla'],
                              "bandwidth": context['bandwidth'],
                            }
  vpn = {"vpn_conf": {object_id: micro_service_vars_array}}
  # call the CREATE for simple_firewall MS for each device
  order = Order(devicelongid)
  order.command_execute('CREATE', vpn)
  if order.response.ok:
      util.log_to_process_file(process_id, vpn)
  else:
    ret = MSA_API.process_content('FAILED', f'update for: {me_id} failed', context, True)
    print (ret)
  
  # extract the database ID for er ID
  devicelongid=er_list[i]['id'][-3:]
  util.log_to_process_file(process_id, devicelongid)
  object_id = "er_"+context['vpn_id']+"_vpn_conf"
  # build the Microservice JSON params for the CREATE
  micro_service_vars_array = {"object_id": object_id,
                              "router": er_list[i]['id'],
                              "vlan_id": context['vlan_id'],
                              "vpn_id": context['vpn_id'],
                              "sla": context['sla'],
                              "bandwidth": context['bandwidth'],
                            }
  vpn = {"vpn_conf": {object_id: micro_service_vars_array}}
  # call the CREATE for simple_firewall MS for each device
  order = Order(devicelongid)
  order.command_execute('CREATE', vpn)
  if order.response.ok:
      util.log_to_process_file(process_id, vpn)
  else:
    ret = MSA_API.process_content('FAILED', f'update for: {me_id} failed', context, True)
    print (ret)
    
ret = MSA_API.process_content('ENDED', f'{ce_list} and {er_list} configured', context, True)
print(ret)