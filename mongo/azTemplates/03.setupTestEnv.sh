#!/bin/bash
az group create --name euseoMongoDBRG01 --location koreacentral
az group deployment create --name networkForMongoDBDeployment --resource-group euseoNetRG01 \
--template-file 00.mongoNet.json \
--parameters vnet_name=euseoVnet01 \
--parameters subnet_name=testSubnet01 \
--parameters publicip_name=euseomongoDBSingleNodeIP \
--parameters dnsPrefix=euseomongodbtest01 \
--parameters nic_name=euseomongodbTestNic01


az group deployment create --name createVM --resource-group euseoMongoDBRG01 --template-file 02.vm.json \
--parameters vm_name=euseomongoTestVM01 \
--parameters adminUserId=euseo \
--parameters nic_name=euseomongodbTestNic01


# disk 두 개 만듬
az group deployment create --name createDataDisk --resource-group euseoMongoDBRG01 --template-file 01.dataDisk.json \
--parameters dataDisk_name=mongodbDataDisk01
az group deployment create --name createDataDisk --resource-group euseoMongoDBRG01 --template-file 01.dataDisk.json \
--parameters dataDisk_name=mongodbDataDisk02
# data disk attach
az vm disk attach --vm-name euseomongoTestVM01 --disk mongodbDataDisk01 --lun 0 --resource-group euseoMongoDBRG01
az vm disk attach --vm-name euseomongoTestVM01 --disk mongodbDataDisk02 --lun 1 --resource-group euseoMongoDBRG01

#disk lun 확인
az vm show --resource-group euseoMongoDBRG01 --name mongoTestVM01 | jq -r .storageProfile.dataDisks
az vm show --resource-group euseoMongoDBRG01 --name mongoTestVM01 | jq -r .storageProfile.dataDisks[].lun