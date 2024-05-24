# Overview
This guide provides simple instructions on how to use the Bicep modules to deploy an Azure Virtual Desktop (AVD) environment. The main file structures the deployment process, referencing different modules for specific resources.

## Main File Structure
The main file defines the parameters and modules needed for the deployment. It sets up a resource group, virtual network, host pool, application group, workspace, virtual machine, AAD join, AVD agent, and necessary permissions. The modules are called sequentially, with dependencies specified to ensure the correct order of resource creation.

- Modules
Resource Group
File: Modules/resourceGroup.bicep
Description: Creates a resource group.

- Virtual Network
File: Modules/virtualNetwork.bicep
Description: Sets up a virtual network with specified subnets.

- Host Pool
File: Modules/hostPool.bicep
Description: Deploys a host pool for the AVD environment.

- Application Group
File: Modules/applicationGroups.bicep
Description: Creates an application group linked to the host pool.

- Workspace
File: Modules/workspace.bicep
Description: Creates a workspace and links it to the application group.

- Virtual Machine
File: Modules/virtualMachine.bicep
Description: Deploys a virtual machine with specified configurations.

- AAD Join
File: Modules/aadJoin.bicep
Description: Configures AAD join for the virtual machine.

- AVD Agent
File: Modules/avdAgent.bicep
Description: Installs the AVD agent on the virtual machine.

- Permissions
File: Modules/azureVirtualDesktopPermissions.bicep
Description: Assigns necessary roles to the principal.

Usage Instructions
Clone the Repository:

sh
Copy code
git clone <repository-url>
cd AzureLabs
Edit Parameters: Update the parameter values in the main.bicep file to match your environment.

Deploy: Use Azure CLI or Azure PowerShell to deploy the main Bicep file.

sh
Copy code
az deployment sub create --location <location> --template-file main.bicep
Monitor Deployment: Check the Azure Portal to monitor the deployment status and ensure all resources are created successfully.

By following these steps and using the provided modules, you can set up a comprehensive Azure Virtual Desktop environment tailored to your requirements.

# Cyber Career Academy Repository
Welcome to the Cyber Career Academy repository!

# Visit our YouTube Channel
Watch our cyber security or AVD playlist for additional resources.
[CyberCareerAcademy](https://www.youtube.com/@CyberCareerAcademy)

# Visit Us
Explore more about Cyber Career Academy at our official website:
[Cyber Career Academy](https://www.cybercareeracademy.tech/)

# Repository
Find all our Azure Lab resources and templates in our GitHub repository:
[Azure Labs Repository](https://github.com/Cyber-Career-Academy/Repository)

# Community
Join our active community on Discord:
[Discord Community](https://discord.gg/zm29aMUZ8U)

# Social Media
Stay updated with our latest activities and news on Instagram:
[Instagram](https://www.instagram.com/cyber_career_academy/)

Follow us on Twitter
[Twitter/X](https://twitter.com/CyberCareerAcad)

# Overview
Currently this repo has Bicep Modules on how to deploy Azure Virtual Desktop