# PowerShell script to check Python and download documentation from GitHub

# Directory where the script is located
$scriptDirectory = $PSScriptRoot
$repositoryUrl = "https://github.com/RT-whs/ExecutorGeneratorDocumentation/archive/refs/heads/gh-pages.zip"
$downloadPath = "$scriptDirectory\ExecutorGeneratorDocumentation.zip"
$extractPath = "$scriptDirectory\ExecutorGeneratorDocumentation"

# Check if Python is installed by checking the PATH environment variable
$pythonCommand = "python"

try {
    # Execute python --version and capture the output
    $pythonVersionOutput = & $pythonCommand --version 2>&1

    # Check if the output contains "Python" followed by a version number
    if ($pythonVersionOutput -match "Python (\d+\.\d+\.\d+)") {
        Write-Host "Python present"
        $pythonPresent = $true
    } else {
        Write-Host "Python not present"
        $pythonPresent = $false
    }
} catch {
    # If python command fails (e.g., not installed or not in PATH)
    Write-Host "Python not present"
    $pythonPresent = $false
}

# If Python is not present, install it
if (-not $pythonPresent) {
    Write-Host "Python is not installed. Installing Python..."

    # Download Python installer
    $pythonInstallerUrl = "https://www.python.org/ftp/python/3.9.13/python-3.9.13-amd64.exe"
    $pythonInstaller = "$env:TEMP\python_installer.exe"
    Invoke-WebRequest -Uri $pythonInstallerUrl -OutFile $pythonInstaller

    # Run the installer silently
    Start-Process -FilePath $pythonInstaller -ArgumentList "/quiet InstallAllUsers=1 PrependPath=1" -Wait
    Remove-Item -Path $pythonInstaller

    Write-Host "Python has been installed successfully."
} else {
    Write-Host "Python is already installed."
}

# Download documentation from GitHub
Write-Host "Downloading documentation from GitHub..."
Invoke-WebRequest -Uri $repositoryUrl -OutFile $downloadPath

# Extract the downloaded zip file
Write-Host "Extracting documentation..."
Expand-Archive -Path $downloadPath -DestinationPath $extractPath -Force

# Remove the unnecessary second folder inside the extracted content
$innerFolderPath = "$extractPath\ExecutorGeneratorDocumentation-gh-pages"
if (Test-Path $innerFolderPath) {
    # Move contents of the inner folder to the parent directory
    Move-Item -Path "$innerFolderPath\*" -Destination $extractPath

    # Remove the inner folder
    Remove-Item -Path $innerFolderPath -Recurse -Force
    Write-Host "Removed unnecessary inner folder: $innerFolderPath"
} else {
    Write-Host "No unnecessary folder found."
}

# Clean up the downloaded zip file
Remove-Item -Path $downloadPath

Write-Host "Documentation has been downloaded, extracted, and cleaned up successfully."
Write-Host "Done! You can now proceed with running the server."
