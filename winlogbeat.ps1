# Execute in an administrative powershell: Set-ExecutionPolicy UnRestricted -Force
# Then Run: ./winlogbeat.ps1
# Version WinlogBeat 8.4.3
Write-Host "Downloading WinlogBeat"
Invoke-WebRequest "https://artifacts.elastic.co/downloads/beats/winlogbeat/winlogbeat-8.4.3-windows-x86_64.zip" -OutFile "winlogbeat.zip" -UseBasicParsing
Expand-Archive "winlogbeat.zip" -Force
Remove-Item "winlogbeat.zip" -Force
Copy-Item .\winlogbeat\winlogbeat-8.4.3-windows-x86_64\ -Destination "C:\Program Files\" -Recurse -Force
Write-Host "WinlogBeat in path C:\Program Files\winlogbeat\"
Remove-Item .\winlogbeat\ -Force -Recurse
Set-Location "C:\Program Files\"
Rename-Item "winlogbeat-8.4.3-windows-x86_64" "winlogbeat" -Force
Set-Location "C:\Program Files\winlogbeat\"
Write-Host "Installing service WinlogBeat"
.\install-service-winlogbeat.ps1 -Force -Verbose
Write-Host "Testing WinlogBeat"
.\winlogbeat.exe test config -c .\winlogbeat.yml
Write-Host "Configuration at C:\Program Files\winlogbeat\winlogbeat.yml"
Write-Host "For start WinlogBeat in an administrator PowerShell: Start-Service winlogbeat"
Set-ExecutionPolicy Undefined -Force