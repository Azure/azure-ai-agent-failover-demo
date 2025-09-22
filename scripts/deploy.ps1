param(
    [Parameter(Mandatory=$true)]
    [string]$Region
)

$resourceGroup = "agent-failover-rg-$Region"

# Ensure logged in
try {
    az account show | Out-Null
} catch {
    az login
}

# Create resource group
az group create --name $resourceGroup --location $Region

# Deploy Bicep template
az deployment group create `
  --resource-group $resourceGroup `
  --template-file ./infra/main.bicep `
  --parameters location=$Region projectName=demoAgentProject agentName=demoAgent

Write-Host "Deployment completed in $Region."
