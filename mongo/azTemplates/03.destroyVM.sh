#!/bin/bash
az vm delete -y --name mongoTestVM01 --resource-group euseoMongoDBRG01
az disk delete -y --name mongoTestVM01_OsDisk1 --resource-group euseoMongoDBRG01

#아래는 data disk만 삭제
az vm disk detach --name mongodbDataDisk01 --vm-name mongoTestVM01 --resource-group euseoMongoDBRG01
az vm disk detach --name mongodbDataDisk02 --vm-name mongoTestVM01 --resource-group euseoMongoDBRG01
az disk delete -y --name mongodbDataDisk01 --resource-group euseoMongoDBRG01
az disk delete -y --name mongodbDataDisk02 --resource-group euseoMongoDBRG01
#새로 disk 만들었다면 attach는 
az vm disk attach --disk mongodbDataDisk01 --vm-name mongoTestVM01 --resource-group euseoMongoDBRG01