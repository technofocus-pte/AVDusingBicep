param location string

param tags object 

param applicationGroupName string

param hostpoolId string 

param applicationGroupType string = 'Desktop'

var sessionDesktop = 'sessionDesktop'


resource applicationGroup 'Microsoft.DesktopVirtualization/applicationGroups@2024-01-16-preview' = {
 name: applicationGroupName
 location: location
 properties: {
  friendlyName: sessionDesktop
  hostPoolArmPath: hostpoolId
  applicationGroupType: applicationGroupType
 }
}

output applicationGroupName string = applicationGroup.name
output applicationGroupId string = applicationGroup.id
