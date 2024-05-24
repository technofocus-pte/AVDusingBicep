targetScope = 'subscription'

param resourceGroupName string

param location string

param storageAccountName string 

module resourceGroupDeployment '../modules/mgmt/resourceGroup.bicep' = {
  name: resourceGroupName
  params: {
    resourceGroupName: resourceGroupName
    location: location
  }
}

module storageAccount '../modules/data/storageAccount.bicep' = {
  dependsOn: [
    resourceGroupDeployment
  ]
  name: storageAccountName
  scope: resourceGroup(resourceGroupName)
  params: {
   location: location
   storageAccountName: storageAccountName
  }
}
