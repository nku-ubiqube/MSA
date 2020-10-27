from msa_sdk.variables import Variables
from msa_sdk.msa_api import MSA_API

dev_var = Variables()
dev_var.add('vpn_name', var_type='String')
dev_var.add('ce_list.0.id', var_type='Device')
dev_var.add('er_list.0.id', var_type='String')
dev_var.add('vlan_id', var_type='Integer')
dev_var.add('vpn_id', var_type='String')
dev_var.add('sla', var_type='String')
dev_var.add('bandwidth', var_type='Integer')
context = Variables.task_call(dev_var)

ce_list = context['ce_list']
er_list = context['er_list']

ret = MSA_API.process_content('WARNING', f'Work In Progress, CE List {ce_list}, ER List {er_list}', context, True)

print(ret)