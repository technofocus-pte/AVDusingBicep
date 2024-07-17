@description('Username for the Virtual Machine.')
param adminUsername string = 'avdadmin'

@description('Password for the Virtual Machine.')
@minLength(12)
@secure()
param adminPassword string = 'P@55w.rd1234'

param offer string = 'windows-10'

param publisher string = 'microsoftwindowsdesktop'

param sku string = 'win10-22h2-avd'

param version string = ''

@description('Size of the virtual machine.')
param vmSize string = 'Standard_B4ms'

@description('Location for all resources.')
param location string

@description('Name of the virtual machine.')
param vmName string = 'simple-vm'

@allowed([
  'Standard'
  'TrustedLaunch'
])
param securityType string = 'Standard'

param nicName string = 'nic-${vmName}'

param subnetName string 

param virtualNetworkName string 

var securityProfileJson = {
  uefiSettings: {
    secureBootEnabled: true
    vTpmEnabled: true
  }
  securityType: securityType
}

resource nic 'Microsoft.Network/networkInterfaces@2022-05-01' = {
  name: nicName
  location: location
  properties: {
    ipConfigurations: [
      {
        name: 'ipconfig1'
        properties: {
          publicIPAddress: {
            
          }
          privateIPAllocationMethod: 'Dynamic'
          subnet: {
            id: resourceId('Microsoft.Network/virtualNetworks/subnets', virtualNetworkName, subnetName)
          }
        }
      }
    ]
  }
}

resource vm 'Microsoft.Compute/virtualMachines@2022-03-01' = {
  name: vmName
  location: location
  properties: {
    hardwareProfile: {
      vmSize: vmSize
    }
    osProfile: {
      computerName: vmName
      adminUsername: adminUsername
      adminPassword: adminPassword
    }
    storageProfile: {
      imageReference: {
        publisher: publisher
        offer: offer
        sku: sku
        version: (empty(version) ? 'latest' : version)
      }
      osDisk: {
        createOption: 'FromImage'
        managedDisk: {
          storageAccountType: 'StandardSSD_LRS'
        }
      }
      dataDisks: [
        {
          diskSizeGB: 1023
          lun: 0
          createOption: 'Empty'
        }
      ]
    }
    networkProfile: {
      networkInterfaces: [
        {
          id: nic.id
        }
      ]
    }
    securityProfile: ((securityType == 'TrustedLaunch') ? securityProfileJson : null)
  }
}

output virtualMachineName string = vm.name
output virtualMachineId string = vm.id
