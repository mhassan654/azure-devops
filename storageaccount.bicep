param location string =resourceGroup().location
param namePrefix string ='storage'

var storageAccountName = '${namePrefix}${uniqueString(resourceGroup().id)}'
var storageAccountSku = 'Standard_RAGRS'

resource storageAccount 'Microsoft.Storage/storageAccounts@2023-04-01'={
  name:storageAccountName
  location: location
  kind:'StorageV2'
  sku:{
    name: storageAccountSku
  }
  properties:{
    accessTier:'Hot'
    supportsHttpsTrafficOnly:true
  }
}

output storageAccountid string = storageAccount.id
