Connect-AzAccount
#If you have multiple Azure subscriptions, choose the subscription you want to use. Replace SubscriptionName with you
Set-AzContext SubscriptionName

#Create Resource Group
New-AzResourceGroup `
  -Name myResourceGroup `
  -Location "Central US"

az group create \
--name myResourceGroup \
--location 'Central US'

#Deploy Template
$templateFile = "path-to-the-template-file"
New-AzResourceGroupDeployment `
  -Name blanktemplate `
  -ResourceGroupName myResourceGroup `
  -TemplateFile $templateFile

templateFile=p"ath-to-the-template-file"
az deployment group create \
  --name blanktemplate \
  --resource-group myResourceGroup \
  --template-file $templateFile

# Add Resource to the Template

# Add Parameters to the template
    #- Primarily to make template resuable
    #redeploy Template with parameter storageName:
    New-AzResourceGroupDeployment `
    -Name addskuparameter `
    -ResourceGroupName myResourceGroup `
    -TemplateFile $templateFile `
    -storageName "{your-unique-name}"


#Add Template functions to your ARM template

"location": {
    "type": "string",
    "defaultValue": "[resourcegroup().Location]"
}

#Add variables to your ARM template
#Helpful in providing unique names
"variables": {
  "uniqueStorageName": "[concat(parameters('storagePrefix'), uniqueString(resourceGroup().id))]"
}

