using 'main.bicep'


param tags = {
  'deployed By': 'IAC AVD BootCamp'
}

param location = 'WestUs'

param resourceGroupName = 'rg-avdlab-prd-wus'

//hostpool Params
param hostPoolName = 'hp-avdlab-prd-wus'

// applicationGroup Params
param applicationGroupName = 'ag-avdlab-prd-wus'

//Workspace Params 
param workspaceName = 'ws-avdlab-prd-wus'

// Virtual Network Parameters
param virtualNetworkName = 'vnet-avdlab-prd-wus'

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

param vmName = 'vmavdprd01'

param securityType = 'Standard'

//Permissions Params
param principalId = 'b38b577a-000a-4db2-85de-b30bf73a5fb2'
