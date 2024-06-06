param location string

param tags object

param vmName string

resource existingVirtualMachine 'Microsoft.Compute/virtualMachines@2023-09-01' existing = {
  name: vmName
}

resource aadJoin 'Microsoft.Compute/virtualMachines/extensions@2020-06-01' = {
  parent: existingVirtualMachine
  name: 'AADLoginForWindows'
  location: location
  tags: tags
  properties: {
    publisher: 'Microsoft.Azure.ActiveDirectory'
    type: 'AADLoginForWindows'
    typeHandlerVersion: '2.0'
    autoUpgradeMinorVersion: true
  }
}

