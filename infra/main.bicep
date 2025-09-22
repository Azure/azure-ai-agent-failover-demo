param location string
param projectName string
param agentName string

// Azure AI Foundry project
resource aiProject 'Microsoft.CognitiveServices/accounts@2023-05-01' = {
  name: projectName
  location: location
  kind: 'AIServices'
  sku: {
    name: 'S0'
  }
  properties: {
    customSubDomainName: projectName
  }
}

// Storage for agent state/logs
resource agentStorage 'Microsoft.Storage/storageAccounts@2023-01-01' = {
  name: toLower('${agentName}storage${uniqueString(resourceGroup().id)}')
  location: location
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
}

// App Service Plan
resource appPlan 'Microsoft.Web/serverfarms@2023-01-01' = {
  name: '${agentName}-plan'
  location: location
  sku: {
    name: 'B1'
    tier: 'Basic'
    size: 'B1'
    capacity: 1
  }
}

// App Service hosting the agent runtime
resource agentApp 'Microsoft.Web/sites@2023-01-01' = {
  name: '${agentName}-app'
  location: location
  kind: 'app'
  properties: {
    httpsOnly: true
    serverFarmId: appPlan.id
  }
}

output projectEndpoint string = aiProject.properties.endpoint
output appUrl string = agentApp.defaultHostName
