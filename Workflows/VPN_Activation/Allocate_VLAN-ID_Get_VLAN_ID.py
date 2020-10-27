from msa_sdk.variables import Variables
from msa_sdk.msa_api import MSA_API
from msa_sdk.order import Order
import json

dev_var = Variables()
context = Variables.task_call()

file_system_device_id = "125"

order = Order(file_system_device_id)
order.command_execute('IMPORT', {"VLAN_Database":"0"})
vlan_database = json.loads(order.content.decode())

txt = vlan_database['message']

for vlan in range(255):
  pattern = str(vlan)
  data = txt.find(""+pattern+"")
  if data == -1:
    break

context['vlan_id'] = vlan 

ret = MSA_API.process_content('ENDED', f'Available VLAN-ID: {vlan}', context, True)
print(ret)