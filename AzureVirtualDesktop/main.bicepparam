using 'main.bicep'


param tags = {
  'deployed By': 'IAC AVD BootCamp'
}

param location = 'WestUs'

param resourceGroupName = 'rg-avd-iac-wus'

//hostpool Params
param hostPoolName = 'hp-avd-iac-wus'

// applicationGroup Params
param applicationGroupName = 'ag-avd-iac-wus'

//Workspace Params 
param workspaceName = 'ws-avd-iac-wus'

// Virtual Network Parameters
param virtualNetworkName = 'vnet-avd-iac-wus'

param vnetCIDR = '10.0.0.0/20'

param subnets = [
  {
    name: 'subnet1'
    addressPrefix: '10.0.1.0/24'
  }
]

// Virtual Machine params
param adminUsername = 'avdadmin'

param adminPassword  = 'P@55w.rd1234'

param OSVersion = 'win10-22h2-avd'

param vmSize = 'Standard_B4ms'

param vmName = 'vm-avd-iac-01'

param securityType = 'Standard'

//Permissions Params
param principalId = '3521d794-1a58-4a46-9b3b-70c41fa64be2'
