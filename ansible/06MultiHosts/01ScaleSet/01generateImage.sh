ansible-playbook 01-1deprovision.yml
az vm deallocate --resource-group euseoVM01 --name vm0
az vm generalize --resource-group euseoVM01 --name vm0
az image create --resource-group euseoNetRG01 --name centOSWithCommonTask --source /subscriptions/7b13dc94-2b54-4cdf-a247-bbdebdb97f4f/resourceGroups/euseoVM01/providers/Microsoft.Compute/virtualMachines/vm0