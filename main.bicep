param location string = resourceGroup().location
param storageAccountName string = 'ruvtfstore${uniqueString(resourceGroup().id)}'

var vnetName = 'vnet-for-private-endpoint'
var vnetAddressPrefix = '10.0.0.0/16'
var subnet1Prefix = '10.0.0.0/24'
var subnet1Name = 'subnet-for-private-endpoint'
var privateEndpointName = 'private-endpoint-for-storage-account'
var privateDnsZoneName = 'privatelinkzone.local'
var pvtEndpointDnsGroupName = '${privateEndpointName}/mydnsgroupname'

// create publicly inaccessible storage account
resource storageAccount 'Microsoft.Storage/storageAccounts@2022-09-01' = {
  name: storageAccountName
  location: location
  tags: {
    WhateverIsAutomaticallySetInOurSubscription: 'SomeImportantID'
  }
  sku: {
    name: 'Standard_GRS'
  }
  kind: 'StorageV2'
  properties:{
    accessTier: 'Hot'
    allowBlobPublicAccess: false
    minimumTlsVersion: 'TLS1_2'
    publicNetworkAccess: 'Disabled'
  }
}

// create blob container within the storage account
resource storageContainer 'Microsoft.Storage/storageAccounts/blobServices/containers@2022-09-01' = {
  name: '${storageAccount.name}/default/tfcontainer'
}

// the virtual network where the private endpoint is deployed
resource vnet 'Microsoft.Network/virtualNetworks@2021-05-01' = {
  name: vnetName
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        vnetAddressPrefix
      ]
    }
  }
}

resource subnet 'Microsoft.Network/virtualNetworks/subnets@2021-05-01' = {
  parent: vnet
  name: subnet1Name
  properties: {
    addressPrefix: subnet1Prefix
    // TODO: what does this do?
    // "Enable or Disable apply network policies on private end point in the subnet." - https://learn.microsoft.com/en-us/azure/templates/microsoft.network/virtualnetworks?pivots=deployment-language-bicep
    privateEndpointNetworkPolicies: 'Disabled'
  }
}

// the private endpoint to access the storage account
resource privateEndpoint 'Microsoft.Network/privateEndpoints@2021-05-01' = {
  name: privateEndpointName
  location: location
  properties: {
    subnet: {
      id: subnet.id
    }
    privateLinkServiceConnections: [
      {
        name: privateEndpointName
        properties: {
          // TODO: is this modification for storage account correct?
          // "The resource id of private link service." - https://learn.microsoft.com/en-us/azure/templates/microsoft.network/privateendpoints?pivots=deployment-language-bicep
          privateLinkServiceId: storageAccount.id
          // "The ID(s) of the group(s) obtained from the remote resource that this private endpoint should connect to" - https://learn.microsoft.com/en-us/azure/templates/microsoft.network/privateendpoints?pivots=deployment-language-bicep
          groupIds: [
            'blob'
          ]
        }
      }
    ]
  }
  dependsOn: [
    vnet
  ]
}
