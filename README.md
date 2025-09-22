# Azure AI Foundry Agent Failover Demo

This repository demonstrates a **failover plan** for Azure AI Foundry Agent Service by rehydrating agents in a secondary region and testing all major agent APIs after deployment.

---

## Repository Structure

/agent-failover-demo
/infra
main.bicep # Bicep template for Foundry project + agent infra
variables.json # Parameter file for deployments
/agent-config
agent.json # Agent definition (instructions, tools, settings)
connections.json # Tool/service connection configs
/scripts
deploy.ps1 # PowerShell deployment script
deploy.sh # Bash deployment script
failover.sh # Orchestrates rehydration in backup region
test-agent.py # Calls all major Agent APIs
/samples
notebook-demo.ipynb # Python SDK demo
app-demo.py # Simple app consuming the agent
README.md

---

## Overview

1. Deploy the infra to the **primary region**.
2. Deploy the **agent definition** (`agent.json`) and connections (`connections.json`).
3. Run `scripts/test-agent.py` to verify the agent APIs work (create, chat, list tools, delete).
4. Run `scripts/failover.sh` to redeploy the same infra in a **secondary region**.
5. Re-run `scripts/test-agent.py` to confirm all APIs work after failover.

---

## Prerequisites

- Azure subscription
- Azure CLI or PowerShell
- Python 3.x with `requests` module
- Optional: GitHub Actions for automated deployment/failover

---

## Deployment

### Bash

```bash
# Deploy to primary region
./scripts/deploy.sh eastus

# Simulate failover to secondary region
./scripts/failover.sh westus

# powershell
# Deploy to primary region
./scripts/deploy.ps1 -Region eastus

# bash 
# Set environment variables
export AGENT_PROJECT=<your_project_name>
export AZURE_AI_KEY=<your_api_key>

# Run Python test script
python scripts/test-agent.py
