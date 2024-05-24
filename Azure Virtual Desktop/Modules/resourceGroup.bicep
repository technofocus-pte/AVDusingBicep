targetScope = 'subscription'

param tags object

param location string

param resourceGroupName string

resource resourceGroupResource 'Microsoft.Resources/resourceGroups@2023-07-01' = {
  name: resourceGroupName
  location: location
  tags: tags 
  properties: {}
}


output resourceGroupName string = resourceGroupResource.name
output resorceGroupID string = resourceGroupResource.id
