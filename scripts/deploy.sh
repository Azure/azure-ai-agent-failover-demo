#!/bin/bash

set -e

if [ -z "$1" ]; then
  echo "Usage: ./deploy.sh <region>"
  exit 1
fi

REGION=$1
RESOURCE_GROUP="agent-failover-rg-$REGION"

# Ensure logged in
az account show >/dev/null 2>&1 || az login

# Create resource group
az group create --name $RESOURCE_GROUP --location $REGION

# Deploy Bicep
az deployment group create \
  --resource-group $RESOURCE_GROUP \
  --template-file ./infra/main.bicep \
  --parameters location=$REGION projectName=demoAgentProject agentName=demoAgent

echo "Deployment completed in $REGION."
