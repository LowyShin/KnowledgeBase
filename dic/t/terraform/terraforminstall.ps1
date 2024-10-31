$tfversion = "1.2.6"
$uri = "https://releases.hashicorp.com/terraform/${tfversion}/terraform_${tfversion}_windows_amd64.zip"
$outPath = Join-Path $env:TEMP "terraform_${tfversion}_windows_amd64.zip"
$destPath = 'C:\hashicorp\terraform'

Invoke-WebRequest -Uri $uri -OutFile $outPath

Expand-Archive -Path $outPath -DestinationPath $destPath -Force
##[Environment]::SetEnvironmentVariable('PATH', [Environment]::GetEnvironmentVariable('PATH', 'User') + ";$destPath", 'User')

Remove-Item $outPath
