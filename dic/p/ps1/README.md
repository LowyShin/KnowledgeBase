# Windows PowerShell


## Basic information and tips

* File extension : `ps1`

* Basic execute command : `powershell -C "myshell.ps1"`

* Permission control
  * `Get-ExecutionPolicy`
  * `Set-ExecutionPolicy -Scope CurrentUser RemoteSigned -Force`
    * If you see permission error, then execute above once.
    * It can be executed when download ps1 script
  * Ref : https://github.com/LowyShin/giipdoc-ko/wiki/Powershell-%EA%B6%8C%ED%95%9C-%EB%AC%B8%EC%A0%9C-%ED%95%B4%EA%B2%B0

### Upgrade Powershell ISE
- Powershell ISEは7はサポートしてないためPowershell 7をインストールしてpwshなどのコマンドで実行してPowershell上にまたPowershell7を立ち上げる方にする。

- Rund below and press "ALT+F5"
    - Powershell ISEでは下記のコードを実行してALT-F5を押すとコマンドプロンプトのPSバージョンが一時的に上がる。（exitまたはISEを立ち上げると元のバージョンに戻る）
```ps1

$psISE.CurrentPowerShellTab.AddOnsMenu.Submenus.Clear()
$psISE.CurrentPowerShellTab.AddOnsMenu.Submenus.Add("Switch to PowerShell 7", { 
        function New-OutOfProcRunspace {
            param($ProcessId)

            $ci = New-Object -TypeName System.Management.Automation.Runspaces.NamedPipeConnectionInfo -ArgumentList @($ProcessId)
            $tt = [System.Management.Automation.Runspaces.TypeTable]::LoadDefaultTypeFiles()

            $Runspace = [System.Management.Automation.Runspaces.RunspaceFactory]::CreateRunspace($ci, $Host, $tt)

            $Runspace.Open()
            $Runspace
        }

        $PowerShell = Start-Process PWSH -ArgumentList @("-NoExit") -PassThru -WindowStyle Hidden
        $Runspace = New-OutOfProcRunspace -ProcessId $PowerShell.Id
        $Host.PushRunspace($Runspace)
}, "ALT+F5") | Out-Null

$psISE.CurrentPowerShellTab.AddOnsMenu.Submenus.Add("Switch to Windows PowerShell", { 
    $Host.PopRunspace()

    $Child = Get-CimInstance -ClassName win32_process | where {$_.ParentProcessId -eq $Pid}
    $Child | ForEach-Object { Stop-Process -Id $_.ProcessId }

}, "ALT+F6") | Out-Null
```
- https://dev.classmethod.jp/articles/using-powershell-core-in-the-windows-powershell-ise/

## [powershell for Azure](https://github.com/LowyShin/KnowledgeBase/blob/master/wiki/ps1/ps-azure.md)

## Advanced tips

* フォーマットの変更
    * Format-Table などを利用した結果を変数に入れてしまうと変数がテキストになってしまいフィールド名で抽出が不可能になるので変数に入れるときは「Format-*」系のオプションは入れないこと
    * データが見れない場合はConvertTo-JSONなどで表示してみると項目名とかデータのフォーマットの間違いが見やすくなるので積極的に活用することをお勧め
- Format type
```ps1
Format-Custom
Format-Hex
Format-List
Format-Table
Format-Wide
```
- [Using Format-Wide for Single-Item Output](https://learn.microsoft.com/ja-jp/powershell/scripting/samples/using-format-commands-to-change-output-view?view=powershell-7.2)


* Export-Csv
  * ex :  ``Get-EventLog system | Export-Csv -path syslog.csv -Encoding UTF8 -NoTypeInformation -Delimiter `t ``
    * `-path` : export path
    * `-Encoding` : `UTF8`, `Default`
    * `-NoTypeInformation` : delete first information line
      * `#TYPE System.Diagnostics.EventLogEntry#system/Microsoft-Windows-GroupPolicy/1500`
    * `-Delimiter` : `` `t ``, `,`

- Write Event
```ps1
EventCreate.exe /L APPLICATION /T ERROR /ID 999 /D "test event"
```
https://www.intellilink.co.jp/column/ms/2022/063000.aspx

- evenlog level

| level name | level |
|--|--|
| CRITICAL | 1 |
| ERROR | 2 |
| WARNING | 3 |
| INFORMATION | 4 |


* CPU usage
```ps1
$cpuinfo = New-Object -TypeName PSCustomObject
$cpu = Get-WmiObject Win32_PerfFormattedData_PerfOS_Processor | ?{$_.Name -match "^[0-9]+$"}
$cpuCnt = 0
foreach($c in $cpu)
{
    $cpuinfo | Add-Member -MemberType NoteProperty -Name $c.Name -Value $c.PercentProcessorTime
    $cputotal = $cputotal + $c.PercentProcessorTime
    $cpuCnt = $cpuCnt + 1
}
$cputotal = $cputotal / $cpuCnt
$cputotal
# for Debug
# Write-Host "CPU Count : $cpuCnt"
# Write-Host "CPU Detail : "
# $cpuinfo
```

* Split files by line
```ps1
# Read parent CSV
$InputFilename = Get-Content '.\source.csv'
$OutputFilenamePattern = 'output_done_'
$LineLimit = 5000
 
# Initialize
$line = 0
$i = 0
$file = 0
$start = 0
 
# Loop all text lines
while ($line -le $InputFilename.Length) {
 
    # Generate child CSVs
    if ($i -eq $LineLimit -Or $line -eq $InputFilename.Length) {
        $file++
        $Filename = "$OutputFilenamePattern$file.csv"
        $InputFilename[$start..($line - 1)] | Out-File $Filename -Force
        $start = $line;
        $i = 0
        Write-Host "$Filename"
    }
 
    # Increment counters
    $i++;
    $line++
}
```
  * https://www.spjeff.com/2017/06/02/powershell-split-csv-in-1000-line-batches/

### Process

- Check running process
```ps1
Get-Process -Name "myapp"
```

- Force stop running process
```ps1
Stop-Process -Name "myapp"
```

### Convert

- Integerに変更
```ps1
$val1 = [int]$str1
```

### File handling

* Compare contents(text) with FileA and FileB
  * `diff (cat FileA) (cat FileB)`

### Math

* Round
  * `[Math]::Round( 4912.83875 , <position> )`
    * <position>
      * 0 : 4912.83875
      * 2 : 4900
      * -2 : 4912.84

sample
```ps1
$num = [Math]::Round(1.4999, -2);
```

### Escape character

### @

```
powershell test-esacpe.ps1 -param1 '`@bbbbbb`'
```

### )

```
powershell test-esacpe.ps1 -param1 'aaaa`)`aaa'
```

## Tools

* [CPU Stress(load) Test](https://github.com/LowyShin/KnowledgeBase/blob/master/wiki/ps1/CPUStressTest.ps1)
* [Memory Stress(load) Test](https://github.com/LowyShin/KnowledgeBase/blob/master/wiki/ps1/MemoryStressTest.ps1)
