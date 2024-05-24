param storageAccountName string 

param location string

param sku object = {
  name: 'Standard_LRS'
}
param kind string = 'StorageV2'

param accessTier string = 'Hot'

resource storageAccount 'Microsoft.Storage/storageAccounts@2023-01-01' = {
  name: storageAccountName
  location: location
  sku: sku
  kind: kind
  properties: {
  accessTier: accessTier
  }
}

output storageAccountName string = storageAccount.name
output storageAccountLocation string = storageAccount.location
