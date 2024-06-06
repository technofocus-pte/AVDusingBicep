param location string

param tags object

param sessionHostName string

param HostPoolName string

param hostpoolToken string

param aadJoin bool = true

var dscURL = 'https://wvdportalstorageblob.blob.core.windows.net/galleryartifacts/Configuration_01-20-2022.zip'

resource existingVirtualMachine 'Microsoft.Compute/virtualMachines@2023-09-01' existing = {
  name: sessionHostName
}

resource sessionHostAVDAgent 'Microsoft.Compute/virtualMachines/extensions@2020-06-01' = {
  parent: existingVirtualMachine
  name: 'sessionHostAVDAgent'
  location: location
  tags: tags
  properties: {
    publisher: 'Microsoft.Powershell'
    type: 'DSC'
    typeHandlerVersion: '2.73'
    autoUpgradeMinorVersion: true
    settings: {
      modulesUrl: dscURL
      configurationFunction: 'Configuration.ps1\\AddSessionHost'
      properties: {
        hostPoolName: HostPoolName
        registrationInfoToken: hostpoolToken
        aadJoin: aadJoin
      }
    }
  }
}
