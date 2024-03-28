param (
  [String]
  $password,
  [String]
  $appId,
  [String]
  $tenantId,
  [String]
  $rgName
)


if (!(Get-Module Az.Resources)) {
    Install-Module -Name Az.Resources -Scope CurrentUser -Verbose -Force
}

if (!(Get-Module Az.Accounts)) {
    Install-Module -Name Az.Accounts -Scope CurrentUser -Verbose -Force  
}

Connect-AzAccount -ServicePrincipal -Tenant $tenantId -Credential (New-Object System.Management.Automation.PSCredential ($appId,(ConvertTo-SecureString $password -AsPlainText -Force)))


New-AzTemplateSpec -ResourceGroupName $rgName -Name northeurope-vnet -Version "v1.0" -TemplateFile .\northeurope-vnet.json -Force -Verbose -Location "northeurope"
New-AzTemplateSpec -ResourceGroupName $rgName -Name northeurope-vnet-domain -Version "v1.0" -TemplateFile .\northeurope-vnet-domain.json -Force -Verbose -Location "northeurope"

