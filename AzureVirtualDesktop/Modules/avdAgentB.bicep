param location string

param tags object

param sessionHostName string

param HostPoolName string

param SessionHostConfigurationVersion string = ''

param hostpoolToken string

param aadJoin bool = true

@description('Specifies whether integrity monitoring will be added to the virtual machine.')
param integrityMonitoring bool = false

@description('System data is used for internal purposes, such as support preview features.')
param systemData object = {}

@description('IMPORTANT: Please don\'t use this parameter as intune enrollment is not supported yet. True if intune enrollment is selected.  False otherwise')
param intune bool = false

var artifactsLocation = 'https://wvdportalstorageblob.blob.core.windows.net/galleryartifacts/Configuration_1.0.02705.330.zip'

resource existingVirtualMachine 'Microsoft.Compute/virtualMachines@2023-09-01' existing = {
  name: sessionHostName
}

resource guestAttestation 'Microsoft.Compute/virtualMachines/extensions@2024-03-01' = if (integrityMonitoring) {
  name: 'GuestAttestation'
  parent: existingVirtualMachine
  location: location
  properties: {
    publisher: 'Microsoft.Azure.Security.WindowsAttestation'
    type: 'GuestAttestation'
    typeHandlerVersion: '1.0'
    autoUpgradeMinorVersion: true
    settings: {
      AttestationConfig: {
        MaaSettings: {
          maaEndpoint: ''
          maaTenantName: 'GuestAttestation'
        }
        AscSettings: {
          ascReportingEndpoint: ''
          ascReportingFrequency: ''
        }
        useCustomToken: 'false'
        disableAlerts: 'false'
      }
    }
  }
}

resource AVDAgent 'Microsoft.Compute/virtualMachines/extensions@2021-07-01' = {
  name: 'Microsoft.PowerShell.DSC'
  parent: existingVirtualMachine
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
        hostPoolName: HostPoolName
        registrationInfoTokenCredential: {
          UserName: 'PLACEHOLDER_DO_NOT_USE'
          Password: 'PrivateSettingsRef:RegistrationInfoToken'
        }
        aadJoin: aadJoin
        UseAgentDownloadEndpoint: true
        aadJoinPreview: (contains(systemData, 'aadJoinPreview') && systemData.aadJoinPreview)
        mdmId: (intune ? '0000000a-0000-0000-c000-000000000000' : '')
        sessionHostConfigurationLastUpdateTime: SessionHostConfigurationVersion
      }
    }
    protectedSettings: {
      Items: {
        RegistrationInfoToken: hostpoolToken
      }
    }
  }
  dependsOn: [
    guestAttestation
  ]
}
