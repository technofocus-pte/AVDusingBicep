using 'main.bicep'


param tags = {
  'deployed By': 'CyberCareerAcademy'
}

param location = 'WestUs3'

param resourceGroupName = 'rg-avd-prd-wus3'

//hostpool Params
param hostPoolName = 'hp-avd-prd-wus3'

// applicationGroup Params
param applicationGroupName = 'ag-avd-prd-wus3'

//Workspace Params 
param workspaceName = 'ws-avd-prd-wus3'

// Virtual Network Parameters
param virtualNetworkName = 'vnet-avd-prd-wus3'

param vnetCIDR = '10.0.0.0/20'

param subnets = [
  {
    name: 'subnet1'
    addressPrefix: '10.0.1.0/24'
  }
]

// Virtual Machine params
param adminUsername = 'azadmin'

param adminPassword = '123!@#ABCabc'

param OSVersion = '2022-datacenter-azure-edition'

param vmSize = 'Standard_B4ms'

param vmName = 'vm-avd-prd-01'

param securityType = 'Standard'
