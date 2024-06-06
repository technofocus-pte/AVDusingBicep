param location string

param tags object

param sessionHostName string

param hostpoolName string

param SessionHostConfigurationVersion string = ''

param hostpoolToken string

param aadJoin bool = true

var artifactsLocation = 'https://wvdportalstorageblob.blob.core.windows.net/galleryartifacts/Configuration_1.0.02705.330.zip'

resource existingVirtualMachine 'Microsoft.Compute/virtualMachines@2023-09-01' existing = {
  name: sessionHostName
}

resource rdshPrefix_vmInitialNumber_Microsoft_PowerShell_DSC 'Microsoft.Compute/virtualMachines/extensions@2021-07-01' =  {
  parent: existingVirtualMachine  
  name: 'Microsoft.PowerShell.DSC'
  tags: tags
    location: location
    properties: {
      publisher: 'Microsoft.Powershell'
      type: 'DSC'
      typeHandlerVersion: '2.73'
      autoUpgradeMinorVersion: true
      settings: {
        modulesUrl: artifactsLocation
        configurationFunction: 'Configuration.ps1\\AddSessionHost'
        properties: {
          hostPoolName: hostpoolName
          registrationInfoTokenCredential: {
            UserName: 'PLACEHOLDER_DO_NOT_USE'
            Password: 'PrivateSettingsRef:RegistrationInfoToken'
          }
          aadJoin: aadJoin
          UseAgentDownloadEndpoint: true
          sessionHostConfigurationLastUpdateTime: SessionHostConfigurationVersion
        }
      }
      protectedSettings: {
        Items: {
          RegistrationInfoToken: hostpoolToken
        }
      }
    }
  }
