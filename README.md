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

## Undeploy

Für den Undeploy kann die Resource Group gelöscht werden.

```bash
az group delete --resource-group=bicep-storage-account
```

Bicep ist derzeit noch nicht so weit, die ausgerollten Ressourcen auch wieder löschen zu können. Folgender Befehl entfernt nur die Deployment Metadaten des Bicep Deployments.

```bash
RESOURCE_GROUP=bicep-storage-account
az deployment group delete \
  --name main \
  --resource-group bicep-storage-account
```
