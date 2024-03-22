param (
    [string]$username,
    [string]$password
)

# Prompt for password if not provided as parameter
if (-not $password) {
    $password = Read-Host "Enter password" -AsSecureString
}

# Convert secure string to plain text
$passwordPlainText = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto([System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($password))

# Define the credentials
$credential = New-Object System.Management.Automation.PSCredential($username, $password)

# List of URLs of the executables to download
$urls = @(
    "http://example.com/downloaded1.exe",
    "http://example.com/downloaded2.exe",
    "http://example.com/downloaded3.exe",
    "http://example.com/extra_download.exe" # Additional URL
)

$errors = @()

foreach ($url in $urls) {
    try {
        # Parse filename from the URL
        $outputFile = Split-Path $url -Leaf

        # Download the file with authentication
        Invoke-WebRequest -Uri $url -OutFile $outputFile -Credential $credential

        # Check if it's an extension or an executable
        if ($outputFile -match '\.exe$') {
            # If it's an executable, start the installation
            Start-Process $outputFile -Wait
        } else {
            # If it's an extension, install it using Visual Studio Code
            Start-Process "code" -ArgumentList "--install-extension $outputFile" -Wait
        }
    } catch {
        $errors += "Error downloading or installing from URL: $url"
    }
}

# Report errors
if ($errors.Count -gt 0) {
    Write-Host "Errors occurred:"
    foreach ($error in $errors) {
        Write-Host $error
    }
}
