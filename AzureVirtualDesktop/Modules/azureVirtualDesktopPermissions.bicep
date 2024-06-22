targetScope = 'subscription'

param principalType string

param principalId string

param date string = utcNow()

var vmLoginRoleId = 'fb879df8-f326-4884-b1cf-06f3ad86be52' // Virtual Machine User Login

var desktopVirtualizationUserId = '1d18fff3-a72a-46b5-b4a9-0b38a3cd7e63' // Desktop Virtualization User

var virtualMachineAdminRoleId = '1c0163c0-47e6-4577-8991-ea5c82e286e4' // Virtual Machine Administrator Login

resource vmLoginRoleAssignment 'Microsoft.Authorization/roleAssignments@2020-10-01-preview' = {
  name: guid(date, vmLoginRoleId, principalId)
  properties: {
   roleDefinitionId: '/subscriptions/${subscription().subscriptionId}/providers/Microsoft.Authorization/roleDefinitions/${vmLoginRoleId}'
   principalId: principalId
   principalType: principalType
  }
}

resource virtualizationUserRoleAssignment 'Microsoft.Authorization/roleAssignments@2020-10-01-preview' = {
  name: guid(date, desktopVirtualizationUserId, principalId)
  properties: {
    roleDefinitionId: '/subscriptions/${subscription().subscriptionId}/providers/Microsoft.Authorization/roleDefinitions/${desktopVirtualizationUserId}'
    principalId: principalId
    principalType: principalType
  }
}

resource virtualMachineAdminRoleAssignment 'Microsoft.Authorization/roleAssignments@2022-04-01' = {
  name: guid(date,virtualMachineAdminRoleId, principalId)
  properties: {
    roleDefinitionId: '/subscriptions/${subscription().subscriptionId}/providers/Microsoft.Authorization/roleDefinitions/${virtualMachineAdminRoleId}'
    principalId: principalId
    principalType: principalType
  }
}


output vmLoginRoleAssignmentId string = vmLoginRoleAssignment.id
output virtualizationUserRoleAssignmentId string = virtualizationUserRoleAssignment.id
output virtualMachineAdminRoleAssignmentId string = virtualMachineAdminRoleAssignment.id
