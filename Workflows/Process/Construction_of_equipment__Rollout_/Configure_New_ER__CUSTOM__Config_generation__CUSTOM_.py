'''
Visit http://[YOUR_MSA_URL]/msa_sdk/ to see what you can import.
'''
from msa_sdk.variables import Variables
from msa_sdk.msa_api import MSA_API
from msa_sdk.order import Order

'''
List all the parameters required by the task

You can use var_name convention for your variables
They will display automaticaly as "Var Name"
The allowed types are:
  'String', 'Boolean', 'Integer', 'Password', 'IpAddress',
  'IpMask', 'Ipv6Address', 'Composite', 'OBMFRef', 'Device'

 Add as many variables as needed
'''
dev_var = Variables()
dev_var.add('construction_name', var_type='String')
dev_var.add('additional_device_name', var_type='Device')
dev_var.add('additional_device_ip', var_type='String')
dev_var.add('network_prefix', var_type='Integer')
dev_var.add('adjacent_cr_name', var_type='String')
dev_var.add('adjacent_cr_ip', var_type='String')

context = Variables.task_call(dev_var)

# read the ID of the selected managed entity
device_id = context['additional_device_name']
# extract the database ID
devicelongid = device_id[-3:]

device_id = context['additional_device_name']
device_ip = context['additional_device_ip']
network_prefix = context['network_prefix']
neighbor_ip = context['adjacent_cr_ip']

'''
if int(network_prefix) == 8:
  netmask = "255.0.0.0"
elif int(network_prefix) == 16:
  netmask = "255.255.0.0"
else:
  netmask = "255.255.255.0"
  
f = open("/opt/fmc_repository/Datafiles/basic.conf", "w")
f.write("router Name "+device_id+"")
f.write("\n")
f.write("ip address "+device_ip+" "+netmask+"")
f.write("\n")
f.write("neighbor "+neighbor_ip+"")
f.close()
'''

# build the Microservice JSON params for the order
micro_service_vars_array = {"object_id": device_id,
                            "device_ip": device_ip,
                            "prefix": network_prefix,
                            "neighbor": neighbor_ip
                            }

object_id = device_id

basic = {"basic_conf_CUSTOM": {object_id: micro_service_vars_array}}

# call the CREATE for simple_firewall MS for each device
order = Order(devicelongid)
order.command_execute('UPDATE', basic)

if order.response.ok:
  ret = MSA_API.process_content('ENDED', f'Generated config for: {context["construction_name"]} CUSTOM', context, True)
else:
  ret = MSA_API.process_content('FAILED', f'Config generation for: {context["construction_name"]} failed CUSTOM', context, True)
print(ret)
