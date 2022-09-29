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

- [Microsoft Azure – Retrieve Azure Virtual Machine Admin User Name](https://www.geeksforgeeks.org/microsoft-azure-retrieve-azure-virtual-machine-admin-user-name/)
```ps1
Get-AZVM `
-Name "Provide_the_Azure_VM_Name_Here" `
-ResourceGroup "Provide_Resource_Group_Name_Here" `
| Select-Object -ExpandProperty OSProfile
```

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
Write-Output "Type your operation. Rule enable[ E/e ], Rule disable[ D/d ]"
$ans = Read-Host

if (($ans -eq 'E') -or ($ans -eq 'e')) {
    $user_op = "enable"
}
elseif (($ans -eq 'D') -or ($ans -eq 'd')) {
    $user_op = "disable"
}

$az_rule_list = Get-AzScheduledQueryRule | Select Name, Enabled | Where-Object {$_.Name -like "alert*(${vm_name})*"}
foreach ($az_rule_row in $az_rule_list){
    $az_rule_row_name = $az_rule_list[$rowsn].Name
    $az_rule_row_status = $az_rule_list[$rowsn].Enabled

    if ($az_rule_row_name -ne ""){
        if ($user_op -eq "enable"){
            Write-Output "Update-AzScheduledQueryRule -ResourceGroupName ""${rg_name}"" -Name ""$az_rule_row_name"" -Enabled $true"
            Update-AzScheduledQueryRule -ResourceGroupName "${rg_name}" -Name "$az_rule_row_name" -Enabled $true
            Write-Output "... Done!"
        }elseif ($user_op -eq "disable"){
            Write-Output "Update-AzScheduledQueryRule -ResourceGroupName ""${rg_name}"" -Name ""$az_rule_row_name"" -Enabled $false"
            Update-AzScheduledQueryRule -ResourceGroupName "${rg_name}" -Name "$az_rule_row_name" -Enabled $false
            Write-Output "... Done!"
        }
    }
    $rowsn++
}

Write-Output "... Result ...!"
Get-AzScheduledQueryRule | Select Name, Enabled | Where-Object {$_.Name -like "alert*(${vm_name})*"}
```
