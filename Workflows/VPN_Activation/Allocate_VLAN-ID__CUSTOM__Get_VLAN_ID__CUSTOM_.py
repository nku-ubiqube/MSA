from msa_sdk.variables import Variables
from msa_sdk.msa_api import MSA_API
from msa_sdk.order import Order
import json

dev_var = Variables()
context = Variables.task_call()

file_system_device_id = "125"

order = Order(file_system_device_id)
order.command_execute('IMPORT', {"VLAN_Database_CUSTOM":"0"})
vlan_database = order.command_objects_instances("VLAN_Database_CUSTOM")

vlan = 511
for i in range(512,1002):
  if str(i) in vlan_database:
    continue
  vlan = str(i)
  break

context['vlan_id'] = vlan 


ret = MSA_API.process_content('ENDED', f'Available VLAN-ID: {vlan} (CUSTOM)', context, True)
print(ret)