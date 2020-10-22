from msa_sdk.variables import Variables
from msa_sdk.msa_api import MSA_API

dev_var = Variables()
dev_var.add('construction_name', var_type='String')
context = Variables.task_call()

ret = MSA_API.process_content('ENDED', f'{context["construction_name"]} configured', context, True)
print(ret)