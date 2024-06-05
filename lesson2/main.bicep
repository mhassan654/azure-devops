 param location string =resourceGroup().location
 param storageAccountName string = 'simplearn${uniqueString(resourceGroup().id)}'
 param appServiceAppName string = 'simplearnstcct${uniqueString(resourceGroup().id)}'

 
resource appServicePlan 'Microsoft.Web/serverfarms@2023-12-01'={
  name:'simplelearndev01'
  location: location
  sku:{
    name:'F1'
  }
}

 resource storageaccount 'Microsoft.Storage/storageAccounts@2021-02-01' = {
   name: storageAccountName
   location: location
   kind: 'StorageV2'
   sku: {
     name: 'Standard_LRS'
   }
   properties:{accessTier:'Hot'}
 }

 resource appServiceApp 'Microsoft.Web/sites@2023-12-01'={
  name:appServiceAppName
  location:location
  properties:{
    serverFarmId: appServicePlan.id
    httpsOnly:true
  }
 }

 
 
//  create a resource group
// az group create -g Demo1 -l weastus

// deploy the bicep file
// az deployment group create -g Demo1 -f ./lesson2/main.bicep
