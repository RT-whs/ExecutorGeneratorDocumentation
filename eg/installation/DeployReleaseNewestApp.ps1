#How to call this script
# Powershell.exe -executionpolicy remotesigned -File .\update.ps1

Start-Sleep -Seconds 2

# Define the folder path
$folderPath = "DeployedApp"
# DeployedApp

# Remove the folder if it exists and create a new one
if (Test-Path $folderPath) {
    Remove-Item -Path $folderPath -Recurse -Force
}
New-Item -ItemType Directory -Path $folderPath

# URL pro otevření v prohlížeči
$tokenUrl = "https://jagps.sharepoint.com/:t:/s/WHSPLCProgrammers/EfiNX-C2s69Csj1vDo1p8OEBN5FcrjCY90ML9VxSaJYVSg?e=11Ecpm"

# Otevře odkaz v prohlížeči
Start-Process $tokenUrl

# Počkejte chvíli, než uživatel zkopíruje token a vloží ho do skriptu
$token = Read-Host "Please paste your token here"

# Zobrazí token pro potvrzení (můžete ho odstranit, pokud nechcete)
Write-Host "Your token is: $token"


$response = Invoke-RestMethod -Uri "https://api.github.com/repos/RT-whs/EGreleases/tags" -Headers @{Authorization = "token $token"} 
$latestRelease = $response | Select-Object -First 1 # Get the latest release

if ($response -eq $null) {
    Write-Host "Failed to fetch data from GitHub API"
    exit
}

# Extract the version number (remove 'v' prefix if exists)
$selected_version = $latestRelease.name -replace '^v', ''

# Define the download URL using the GitHub API
$download_url = "https://api.github.com/repos/RT-whs/EGreleases/zipball/v$selected_version"

# Print the download URL for debugging
Write-Host "Downloading latest version: $selected_version"
Write-Host "Download URL: $download_url"

# Download the selected version
try {
    Invoke-WebRequest -Uri $download_url -Headers @{Authorization = "token $token"} -OutFile "$folderPath\EGreleases.zip" -ErrorAction Stop
} catch {
    Write-Host "Error when downloading file: $_"
    exit 1  # Ukončí skript s kódem chyby 1
}

# Unzip the application directly into a temporary folder
$tempFolder = "$folderPath\temp"
Expand-Archive -Path "$folderPath\EGreleases.zip" -DestinationPath $tempFolder -Force -ErrorAction Stop

# Get the directory name after unzipping
$extractedFolder = Get-ChildItem -Path $tempFolder | Where-Object { $_.PSIsContainer } -ErrorAction Stop

# Move all files from the extracted folder to the main folder
Move-Item -Path "$($extractedFolder.FullName)\*" -Destination $folderPath -Force -ErrorAction Stop

# Remove the temporary folder
Remove-Item -Path $tempFolder -Recurse -Force -ErrorAction Stop

# Remove the zip file after extraction
Remove-Item -Path "$folderPath\EGreleases.zip" -Force -ErrorAction Stop

# Remove any hidden files/folders from the main folder
Get-ChildItem -Path $folderPath -Force | Where-Object { $_.Name.StartsWith('.') } | Remove-Item -Recurse -Force -ErrorAction Stop

Write-Host "Download and extraction complete."
