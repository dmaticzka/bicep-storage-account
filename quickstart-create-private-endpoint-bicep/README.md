# Quickstart Template for creating a private endpoint using Bicep

https://learn.microsoft.com/en-us/azure/private-link/create-private-endpoint-bicep?tabs=CLI

- sets up a private endpoint for an SQL database
- sets up a VM for access

Setup:

```bash
az group create --name quickstart-create-private-endpoint-bicep --location eastus
az deployment group create --resource-group quickstart-create-private-endpoint-bicep --template-file main.bicep --parameters sqlAdministratorLogin=tzk vmAdminUsername=tzk
```

- asks for sqlAdministratorLoginPassword: `HochsicheresPasswort123`
- asks for vmAdminPassword: `HochsicheresPasswort123`
