

@description('the name of the environemt. this must be dev, test, or prod')
@allowed([
  'dev'
  'test'
  'prod'
])
param environmentName string ='dev'

@description('the unique name of the solution. this is used to ensure that resource names are unique')
@minLength(5)
@maxLength(30)
param solutionName string ='toyhr${uniqueString(resourceGroup().id)}'

@description('the number of app service plan instance')
@minValue(1)
@maxValue(10)
param appservicePlanInstanceCount int =1

@description('the name and tier of the app service plan SKU')
param appServicePlanSku object={
  name:'F1'
  tier:'Free'
}

@description('the azure region into which the resources should be deployed')
param location string = 'eastus'

var appServicePlanName = '${environmentName}-${solutionName}-plan'
var appServiceAppName = '${environmentName}-${solutionName}-app'

resource appServicePlan 'Microsoft.Web/serverfarms@2023-12-01'={
  name: appServicePlanName
  location:location
  sku:{
    name: appServicePlanSku.name
    tier:appServicePlanSku.tier
    capacity: appservicePlanInstanceCount
  }
}


resource appServiceApp 'Microsoft.Web/sites@2023-12-01'={
  name:appServiceAppName
  location:location
  properties:{
    serverFarmId:appServicePlan.id
    httpsOnly:true
  }
}
