https://learn.microsoft.com/en-us/azure/virtual-machines/windows/connect-rdp


# get the powershell version on your machine
$psversiontable

# install module
install-module az -Scope AllUsers -Force #while using mac it gives error so just installed for current user

install-module az

#get version details
Get-Module az -ListAvailable

#Update the module using below commands
Update-Module az -Scope AllUsers
update-module az
#NOTE old versions may still be present so try to delete and install the module again

#login to Azure
Connect-AzAccount

#Connect to Azure using organizational ID credentials
$Credential = Get-Credential
Connect-AzAccount -Credential $Credential


get-azcontext -ListAvailable

#rename Subscription
$contexts= get-azcontext -ListAvailable
$contexts[1] | rename-azcontext -TargetName "Rohit Dev"
$contexts[2] | rename-azcontext -TargetName "Rohit Lab"

Select-AzContext "Rohit Dev"

#search commands using module , their verb and their Noun
get-command -module AZ.Compute
# CommandType     Name                                               Version    Source
# -----------     ----                                               -------    ------
# Alias           Get-AzVmssDiskEncryptionStatus                     6.2.0      Az.Compute
# Alias           Get-AzVmssVMDiskEncryptionStatus                   6.2.0      Az.Compute
# Alias           Invoke-AzVMAssessPatch                             6.2.0      Az.Compute
# Alias           Invoke-AzVMPatchAssess                             6.2.0      Az.Compute
# Alias           Repair-AzVmssServiceFabricUD                       6.2.0      Az.Compute

get-command -module AZ.Compute -Verb New
# CommandType     Name                                               Version    Source
# -----------     ----                                               -------    ------
# Function        New-AzGalleryApplication                           6.2.0      Az.Compute
# Function        New-AzGalleryApplicationVersion                    6.2.0      Az.Compute
# Cmdlet          New-AzAvailabilitySet                              6.2.0      Az.Compute
# Cmdlet          New-AzCapacityReservation                          6.2.0      Az.Compute

get-command -module AZ.Compute -Noun AZVM 
# CommandType     Name                                               Version    Source
# -----------     ----                                               -------    ------
# Cmdlet          Get-AzVM                                           6.2.0      Az.Compute
# Cmdlet          New-AzVM                                           6.2.0      Az.Compute
# Cmdlet          Remove-AzVM                                        6.2.0      Az.Compute
# Cmdlet          Restart-AzVM                                       6.2.0      Az.Compute
# Cmdlet          Set-AzVM                                           6.2.0      Az.Compute
# Cmdlet          Start-AzVM                                         6.2.0      Az.Compute
# Cmdlet          Stop-AzVM                                          6.2.0      Az.Compute
# Cmdlet          Update-AzVM                                        6.2.0      Az.Compute

Get-AzResourceGroup
#create Resource Group
New-AzResourceGroup -Name 'myResourceGroup' -Location 'EastUS'

#creating new VM in existing Resource Group
New-AzVm `
    -ResourceGroupName 'myResourceGroup' `
    -Name 'myVM' `
    -Location 'East US' `
    -Image 'MicrosoftWindowsServer:WindowsServer:2022-datacenter-azure-edition:latest' `
    -VirtualNetworkName 'myVnet' `
    -SubnetName 'mySubnet' `
    -SecurityGroupName 'myNetworkSecurityGroup' `
    -PublicIpAddressName 'myPublicIpAddress' `
    -OpenPorts 80,3389

#It will ask for Admin and password
#output: No Size value has been provided. The VM will be created with the default size Standard_D2s_v3.

Get-AzVM -ResourceGroupName RohitAug23
Get-AzVM -Status | Select-object Name, powerstate, autostate
Get-AzVM -status | where {$_.powerstate -ne "VM Running"}

#VMSS 
New-AzVmss `
    -ResourceGroup "myVMSSResourceGroup" `
    -Name "myScaleSet" `
    -OrchestrationMode "Flexible" `
    -Location "East US" `
    -InstanceCount "2" `
    -ImageName "Win2019Datacenter" 

#create VM Inage:
#Get the VM
#Create a resource group
#Create a gallery
#Create an image definition
#Create an image version
#Create a VM
#Share the gallery


##Azure VM Image Builder : 
##Hashicorp's Packer for image building

