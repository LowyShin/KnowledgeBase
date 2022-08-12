<#
.EXAMPLE
.\MemoryStressTest.ps1 80
-> test until 80%

実際のタスクマネージャーから見れるメモリと若干差が出る。
理由はメモリを占有していく際にほかのプロセスのメモリがSWAPなどに変換されメモリが一部解放されてしまう可能性があるため多めに入れてテストするしかない。

.DESCRIPTION
#>

[cmdletbinding()]
param(
[parameter(mandatory=$true)]
[int]$memMaxP
)

# RAM
$box=get-WMIobject Win32_ComputerSystem
$Global:physMB=$box.TotalPhysicalMemory / 1024 /1024

# Create object to get current memory available
$Global:psPerfMEM = new-object System.Diagnostics.PerformanceCounter("Memory","Available Mbytes")
$psPerfMEM.NextValue() | Out-Null

# leave 512Mb for the OS to survive.
$HEADROOM=512

$ram = $physMB - $psPerfMEM.NextValue()
#$maxRAM=$physMB - $HEADROOM
$maxRAM=$physMB

$progress = ($ram / $maxRAM) * 100
$completed  = [int]$progress
$StartDate = Get-Date

Write-Output "=-=-=-=-=-=-=-=-=-=  Memory Stress Started: $StartDate =-=-=-=-=-=-=-=-=-="
Write-Output "mem_stress - This script will consume all but 512MB of RAM available on the machine"
Write-Output "Starting consumed RAM: $ram out of $maxRAM ($completed% Full)"
Write-Output "=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-="
# If you increase the size of the array the GC seems to do quicker cleanups
# Not sure why, but 200MB seems to be the suite spot
$a = "a" * 200MB

# Add Lowy, for fix mem %

# These are the arrays we will create to consume all of the RAM
$growArray = @()
$growArray += $a
$bigArray = @()
$k=0
$lastCompleted = 900

# This loop will continue until we have consumed all of the RAM minus the headroom
while ($ram -lt ($maxRAM * $memMaxP / 100)) {
 $bigArray += ,@($k,$growArray)
 $k += 1
 $growArray += $a
 # Find out how much RAM we are now consuming
 $ram = $physMB - $psPerfMEM.NextValue()
 $progress = ($ram / $maxRAM) * 100
 $completed  = [int]$progress
 $status_string = -join([int]$ram," of ",[int]$maxRAM, "MB ($completed% Complete)")
 # Only show the message when we have a change in percentage
 if ($completed -ne $lastCompleted) {
    Write-Output "$status_string"
    $lastCompleted = $completed
    }
}
Write-Output "=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-="
# Do a final check of RAM after consuming it all
$ram = $physMB - $psPerfMEM.NextValue()
Write-Output "FINAL $ram / $maxRAM"

Read-Host -Prompt "Press any key to quit"

Write-Output "Clearing RAM"
#####################
# and now release it all.
$bigArray.clear()
#remove-variable bigArray
$growArray.clear()
#remove-variable growArray
[System.GC]::Collect()
#####################

$ram = $physMB - $psPerfMEM.NextValue()
Write-Output "RAM HAS BEEN CLEARED: $ram / $maxRAM"

