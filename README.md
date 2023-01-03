# bicep-storage-account

Setup and secure an Azure Storage Account using Bicep

## Deploy

```bash
RESOURCE_GROUP=bicep-storage-account
# create the resource group
az group create --name $RESOURCE_GROUP --location westeurope
# deploy at the resource group level
az deployment group create \
  --template-file main.bicep \
  --resource-group $RESOURCE_GROUP
```
