## Connect Azure Account

```ps1
$TenantId = "2202a6a45-cdd0-4ca1-aa54-80a2c07c2azz"
Connect-AzAccount -TenantId $TenantId
```

## Resource group

- get resource group
```ps1
# get resource group name filtered by *lw*
$rg = Get-AzResourceGroup | Where-Object {$_.ResourceGroupName -like "*lw*"}
# Resource group
$rg_name = $rg.ResourceGroupName
```

## VM

```ps1
$myvm = Get-AzVM
$myvm_name = $myvm.name
```
- if you see command not recognize messeges, you must upgrate az module and powershell version over 7.2

## install and update az module
```ps1
Install-Module -Name Az -Scope CurrentUser -Repository PSGallery -Force
```
- https://learn.microsoft.com/ja-jp/powershell/azure/install-az-ps?view=azps-8.3.0


- update az module
```ps1
Update-Module Az
```
- https://github.com/Azure/azure-powershell

## Management

### Monitor
- Az command for [Monitor > Alert rule]
- [Get-AzScheduledQueryRule](https://learn.microsoft.com/en-us/powershell/module/az.monitor/get-azscheduledqueryrule?view=azps-8.3.0)
```ps1
$vm_name = "myvm"
# get rules filtered name by alert*myvm 
$az_rule_list = Get-AzScheduledQueryRule | Select Name, Enabled | Where-Object {$_.Name -like "alert*(${vm_name})*"}
```
