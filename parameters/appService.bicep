param environmentName string ='dev'
param solutionName string ='toyhr${uniqueString(resourceGroup().id)}'
param appservicePlanInstanceCount int =1
param appServicePlanSku object={
  name:'F1'
  tier:'Free'
  capacity:1
}


param location string = 'eastus'

var appServicePlanName = '${environmentName}-${solutionName}-plan'
var appServiceAppName = '${environmentName}-${solutionName}-app'

@minLength(5)
@maxLength(24)
param storageAccountName string



@description('the locations into which this metadent db account should be configured')
param metadentDBAccountLocations array=[
  {
    locationName:'australiaesat'
  }
  {
    locationName:'westeurope'
  }
]

resource appServicePlan 'Microsoft.Web/serverfarms@2023-12-01'={
  name: appServicePlanName
  location: location
  sku:{
    name:appServicePlanSku.name
    tier:appServicePlanSku.tier
    capacity:appServicePlanSku.capacity
  }
}


resource account 'Microsoft.DocumentDB/databaseAccounts@2024-05-15'={
name: accountName
location:location
properties:{
  locations:metadentAccountLocations
}
}
