import os
import requests

BASE_URL = f"https://{os.environ.get('AGENT_PROJECT')}.cognitiveservices.azure.com/agents"
API_KEY = os.environ.get('AZURE_AI_KEY')

headers = {
    "Content-Type": "application/json",
    "Ocp-Apim-Subscription-Key": API_KEY
}

def test_create_agent():
    payload = {
        "name": "failoverAgent",
        "instructions": "Assist customers with FAQs after failover",
        "model": {"provider": "azureOpenAI", "deployment": "gpt-4o-mini", "temperature": 0.7}
    }
    r = requests.post(f"{BASE_URL}/agents", headers=headers, json=payload)
    print("Create Agent:", r.status_code, r.text)
    return r.json().get("id")

def test_chat(agent_id):
    payload = {"input": "Hello, are you running in the failover region?"}
    r = requests.post(f"{BASE_URL}/agents/{agent_id}/chat", headers=headers, json=payload)
    print("Chat:", r.status_code, r.json())

def test_tools(agent_id):
    r = requests.get(f"{BASE_URL}/agents/{agent_id}/tools", headers=headers)
    print("List Tools:", r.status_code, r.json())

def test_delete(agent_id):
    r = requests.delete(f"{BASE_URL}/agents/{agent_id}", headers=headers)
    print("Delete Agent:", r.status_code)

if __name__ == "__main__":
    agent_id = test_create_agent()
    if agent_id:
        test_chat(agent_id)
        test_tools(agent_id)
        test_delete(agent_id)
