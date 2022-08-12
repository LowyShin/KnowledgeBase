<#
.SYNOPSIS
このスクリプトはCPUのコアごとに100%負荷をかけます。

.DESCRIPTION

「NumHyperCores」変数にコア数を入力するとその分のJobを起動して処理を行います。
Hyper-Threading機能がenable状態の場合その数分の数字をご入力ください。

.PARAMETER <NumHyperCores>

.INPUTS
None.

.実行例
.\CPUStressTest.ps1 -NumHyperCores 4
権限イシューで実行できない場合まずPowerShellIDEを管理者権限に実行し、下記の権限を変えます。
PowerShell Set-ExecutionPolicy RemoteSigned
権限確認
PowerShell Get-ExecutionPolicy 

.NOTES
TAG:PUBLIC
#>

[cmdletbinding()]
param(
[parameter(mandatory=$true)]
[int]$NumHyperCores
)

# ログファイル格納場所を変える場合は修正してください。
$Log = "C:\temp\CPUStressTest.ps1.log"

$StartDate = Get-Date
Write-Output "============= CPU Stress Test Started: $StartDate =============" >> $Log
Write-Output "Started By: $env:username" >> $Log
Write-Warning "This script will potentially saturate CPU utilization!"
$Prompt = Read-Host "Are you sure you want to proceed? (Y/N)"

if ($Prompt -eq 'Y')
{
	Write-Warning "To cancel execution of all jobs, close the PowerShell Host Window."
	Write-Output "Hyper Core Count: $NumHyperCores" >> $Log

foreach ($loopnumber in 1..$NumHyperCores){
    Start-Job -ScriptBlock{
    $result = 1
        foreach ($number in 1..2147483647){
            $result = $result * $number
        }# end foreach
    }# end Start-Job
}# end foreach

Wait-Job *
Clear-Host
Receive-Job *
Remove-Job *
}# end if

else{
	Write-Output "Cancelled!"
}

$EndDate = Get-Date
Write-Output "============= CPU Stress Test Complete: $EndDate =============" >> $Log
