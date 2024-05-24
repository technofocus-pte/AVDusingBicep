targetScope = 'subscription'

param resourceGroupName string

param location string

resource resourceGroup 'Microsoft.Resources/resourceGroups@2023-07-01' = {
  name: resourceGroupName
  location: location
  properties: {
  }
}

output resourceGroupnName string = resourceGroup.name
output resourceGroupID string = resourceGroup.id
