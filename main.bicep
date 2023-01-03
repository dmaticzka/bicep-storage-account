param location string = resourceGroup().location
param storageAccountName string = 'ruvtfstore${uniqueString(resourceGroup().id)}'

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
    accessTier: 'Cool'
    allowBlobPublicAccess: false
    minimumTlsVersion: 'TLS1_2'
    publicNetworkAccess: 'Disabled'
  }
}
