from msa_sdk.variables import Variables
from msa_sdk.msa_api import MSA_API
from msa_sdk.order import Order
from msa_sdk import util
import json

dev_var = Variables()
dev_var.add('name', var_type='String')
dev_var.add('device.0.target', var_type='Device')
dev_var.add('version', var_type='String')
dev_var.add('additional_device', var_type='String')
dev_var.add('additional_version', var_type='String')
context = Variables.task_call(dev_var)

process_id = context['SERVICEINSTANCEID']
matched_devices = dict()

devices = context['device']
for i in range(len(devices)):
  # extract the database ID for ce ID
  devicelongid = devices[i]['target'][-3:]
  order = Order(devicelongid)
  order.command_execute('IMPORT', {"Apache_Version":"0"})
  order.command_objects_instances("Apache_Version")
  version = json.loads(order.content)[0]
  # order.command_objects_instances_by_id("Apache_Version", "8_5_59")
  order.command_objects_instances_by_id("Apache_Version", version)
  ver = json.loads(order.content)['Apache_Version'][version]['object_id']
  if ver != context['version']:
    matched_devices[devicelongid] = list()
    matched_devices[devicelongid].append({'id': devicelongid})

devicelongid = context['additional_device'][-3:]
order = Order(devicelongid)
order.command_execute('IMPORT', {"Apache_Version":"0"})
order.command_objects_instances("Apache_Version")
version = json.loads(order.content)[0]
# order.command_objects_instances_by_id("Apache_Version", "8_5_59")
order.command_objects_instances_by_id("Apache_Version", version)
ver = json.loads(order.content)['Apache_Version'][version]['object_id']
if ver != context['additional_version']:
  matched_devices[devicelongid] = list()
  matched_devices[devicelongid].append({'id': devicelongid})

ret = MSA_API.process_content('ENDED', f'Apache will be updated on {matched_devices}', context, True)
print(ret)