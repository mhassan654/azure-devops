
param location string = resourceGroup().location
param storageAccountName string = 'simplearn${uniqueString(resourceGroup().id)}'
param appServiceAppName string = 'simplearnstcct${uniqueString(resourceGroup().id)}'

@allowed([
  'nonprod'
  'prod'
])
param environmentType string

var storageAccountSkuName = (environmentType == 'prod') ? 'Standard_GRS' : 'Standard_LRS'

resource storageaccount 'Microsoft.Storage/storageAccounts@2021-02-01' = {
  name: storageAccountName
  location: location  
  sku: {
    name: storageAccountSkuName
  }
  kind: 'StorageV2'
  properties: { accessTier: 'Hot' }
}

module app 'appService.bicep'={
  name: 'app'
  params:{
appServiceAppName:appServiceAppName
environmentType:environmentType
location:location
  }
}

output appServiceAppHostName string = app.outputs.appServiceAppHostName 


//  create a resource group
// az group create -g Demo1 -l weastus

// deploy the bicep file
// az deployment group create -g Demo1 -f ./lesson2/main.bicep
