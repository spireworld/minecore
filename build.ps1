PowerShell
@'
$ErrorActionPreference = 'Stop'
$root = Split-Path -Parent $MyInvocation.MyCommand.Path
Set-Location $root

Write-Host '[1/3] Building MineCore.Launcher...' -ForegroundColor Cyan
dotnet publish MineCore.Launcher/MineCore.Launcher.csproj -c Release -o build/launcher

Write-Host '[2/3] Packing payload for Installer...' -ForegroundColor Cyan
$payload = 'Installer/Payload/launcher.zip'
New-Item -ItemType Directory -Force -Path (Split-Path $payload) | Out-Null
if (Test-Path $payload) { Remove-Item $payload -Force }
Compress-Archive -Path 'build/launcher/*' -DestinationPath $payload

Write-Host '[3/3] Building Installer.exe...' -ForegroundColor Cyan
dotnet publish Installer/Installer.csproj -c Release -o artifacts

Write-Host "Done: $root\artifacts\Installer.exe" -ForegroundColor Green
'@ | Set-Content -Path .\build.ps1 -Encoding UTF8