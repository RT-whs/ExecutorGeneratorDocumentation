# Path where the PowerShell script is located
$scriptDirectory = $PSScriptRoot
$documentationPath = "$scriptDirectory\ExecutorGeneratorDocumentation"

# Navigate to the directory containing the documentation
Set-Location -Path $documentationPath

# Check if Python server is already running and stop it if necessary
$serverPort = 8000
$processes = Get-Process -Name python -ErrorAction SilentlyContinue
foreach ($process in $processes) {
    if ($process.StartInfo.Arguments -match "http.server") {
        Write-Host "Stopping existing Python server..."
        Stop-Process -Id $process.Id
    }
}

# Start the Python HTTP server to serve the documentation in the background
Write-Host "Starting the documentation server..."
Start-Process "python" -ArgumentList "-m http.server" -WindowStyle Hidden

# URL for the documentation
$serverUrl = "http://127.0.0.1:8000/ExecutorGeneratorDocumentation-gh-pages/"

# Open the documentation in the default browser
Write-Host "Opening documentation in the default browser..."
Start-Process $serverUrl

Write-Host "You can now view the documentation in your browser."
