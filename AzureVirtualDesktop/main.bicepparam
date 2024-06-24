using 'main.bicep'


param tags = {
  'deployed By': 'CyberCareerAcademy'
}

param location = 'WestUs3'

param resourceGroupName = 'rg-avdlab-prd-wus3'

//hostpool Params
param hostPoolName = 'hp-avdlab-prd-wus3'

// applicationGroup Params
param applicationGroupName = 'ag-avdlab-prd-wus3'

//Workspace Params 
param workspaceName = 'ws-avdlab-prd-wus3'

// Virtual Network Parameters
param virtualNetworkName = 'vnet-avdlab-prd-wus3'

param vnetCIDR = '10.0.0.0/20'

param subnets = [
  {
    name: 'subnet1'
    addressPrefix: '10.0.1.0/24'
  }
]

// Virtual Machine params
param adminUsername = 'azadmin'

param adminPassword  = '123!@#ABCabc'

param OSVersion = 'win10-22h2-avd'

param vmSize = 'Standard_B4ms'

param vmName = 'vm-avdlab-prd-01'

param securityType = 'Standard'

//Permissions Params
param principalId = 'b38b577a-000a-4db2-85de-b30bf73a5fb2'
