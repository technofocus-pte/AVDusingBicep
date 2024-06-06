targetScope = 'subscription'

param tags object = {
  'deployed By': 'CyberCareerAcademy'
}

param date string = utcNow()

param location string = 'WestUs3'

param resourceGroupName string = 'rg-avd-prd-wus3'

//hostpool Params
param hostPoolName string = 'hp-avd-prd-wus3'

// applicationGroup Params
param applicationGroupName string = 'ag-avd-prd-wus3'

//Workspace Params 
param workspaceName string = 'ws-avd-prd-wus3'

// Virtual Network Parameters
param virtualNetworkName string = 'vnet-avd-prd-wus3'

param vnetCIDR string = '10.0.0.0/20'

param subnets array = [
  {
    name: 'subnet1'
    addressPrefix: '10.0.1.0/24'
  }
]

// Virtual Machine params
param adminUsername string = 'azadmin'

param adminPassword string = '123!@#ABCabc'

param OSVersion string = 'win10-22h2-avd'

param vmSize string = 'Standard_B4ms'

param vmName string = 'vm-avd-prd-01'

param securityType string = 'Standard'

param principalId string = 'principalId'

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

module virtualMachine 'Modules/virtualMachine.bicep' = {
  dependsOn: [
    RG
    virtualNetwork
  ]
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
  }
}

module aadJoin 'Modules/aadJoin.bicep' = {
  name: 'aadJoin-${vmName}-${date}'
  scope: resourceGroup(resourceGroupName)
  params: {
    location: location
    tags: tags
    vmName: virtualMachine.outputs.virtualMachineName
  }
}

module avdAgent 'Modules/avdAgentB.bicep' = {
  name: 'AVDAGENT-${vmName}-${date}'
  dependsOn: [
    aadJoin
  ]
  scope: resourceGroup(resourceGroupName)
  params: {
    location: location
    tags: tags
    hostpoolToken: hostpool.outputs.hostpoolToken
    hostpoolName: hostpool.outputs.hostpoolName
    sessionHostName: virtualMachine.outputs.virtualMachineName
  }
}

module permissions 'Modules/azureVirtualDesktopPermissions.bicep' = {
  dependsOn: [
    RG
  ]
  name: 'AVDPermissions-${date}'
  params: {
    principalId: principalId
    principalType: 'User'
  }
}
