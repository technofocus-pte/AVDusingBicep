targetScope = 'subscription'

param tags object = {
  'deployed By': 'IAC AVD BootCamp'
}

param date string = utcNow()

param location string = 'WestUs'

param resourceGroupName string = 'rg-avd-prd-wus'

//hostpool Params
param hostPoolName string = 'hp-avd-prd-wus'

// applicationGroup Params
param applicationGroupName string = 'ag-avd-prd-wus'

//Workspace Params 
param workspaceName string = 'ws-avd-prd-wus'

// Virtual Network Parameters
param virtualNetworkName string = 'vnet-avd-prd-wus'

param vnetCIDR string = '10.0.0.0/16'

param subnets array = [
  {
    name: 'subnet1'
    addressPrefix: '10.0.0.0/24'
  }
  {
    name: 'subnet2'
    addressPrefix: '10.0.1.0/24'
  }
]

// Virtual Machine params
param adminUsername string = 'avdadmin'

param adminPassword string = 'P@55w.rd1234'

param OSVersion string = 'win10-22h2-avd'

param vmSize string = 'Standard_B4ms'

param vmName string = 'vm-avd-prd-01'

param securityType string = 'Standard'

param principalId string = 'principalId'

param addPermissions bool = false

module RG 'Modules/resourceGroup.bicep' = {
  name: '${resourceGroupName}-${date}'
  params: {
    location: location
    tags: tags
    resourceGroupName: resourceGroupName
  }
}

module virtualNetwork 'Modules/virtualNetwork.bicep' = {
  dependsOn: [
    RG
  ]
  name: '${virtualNetworkName}-${date}'
  scope: resourceGroup(resourceGroupName)
  params: {
    tags: tags
    virtualNetworkName: virtualNetworkName
    subnets: subnets
    vnetCIDR: vnetCIDR
    location: location
  }
}

module hostpool 'Modules/hostPool.bicep' = {
  dependsOn: [
    RG
  ]
  name: '${hostPoolName}-${date}'
  scope: resourceGroup(resourceGroupName)
  params: {
    hostPoolName: hostPoolName
    location: location
    tags: tags
  }
}

module applicationGroup 'Modules/applicationGroups.bicep' = {
  name: '${applicationGroupName}-${date}'
  scope: resourceGroup(resourceGroupName)
  params: {
    location: location
    tags: tags
    applicationGroupName: applicationGroupName
    hostpoolId: hostpool.outputs.hostpoolId
  }
}

module workspace 'Modules/workspace.bicep' = {
  name: '${workspaceName}-${date}'
  scope: resourceGroup(resourceGroupName)
  params: {
    location: location
    tags: tags
    workspaceName: workspaceName
    applicationGroupId: applicationGroup.outputs.applicationGroupId
  }
}

module vm 'Modules/vmModule.bicep' = {
  name: '${vmName}-${date}'
  scope: resourceGroup(resourceGroupName)
  params: {
    location: location
    adminUsername: adminUsername
    adminPassword: adminPassword
    sku: OSVersion
    securityType: securityType
    vmName: vmName
    vmSize: vmSize
    virtualNetworkName: virtualNetworkName
    subnetName: subnets[0].name
    hostpoolToken: hostpool.outputs.hostpoolToken
    hostpoolName: hostpool.outputs.hostpoolName
  }
}


module permissions 'Modules/azureVirtualDesktopPermissions.bicep' = if (addPermissions) {
  dependsOn: [
    RG
  ]
  name: 'AVDPermissions-${date}'
  params: {
    principalId: principalId
    principalType: 'User'
  }
}
