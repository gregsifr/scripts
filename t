# Define the content of the profile script
$profileContent = @"
function ssh {
    param (
        [string]$userAtIp
    )

    # Execute the ssh setup script
    . "\$HOME\setup_ssh.ps1"

    # Run the actual SSH command
    & "C:\Windows\System32\OpenSSH\ssh.exe" \$userAtIp
}
"@

# Path to the PowerShell profile
$profilePath = "$HOME\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1"

# Check if the profile script exists, if not, create it
if (-not (Test-Path $profilePath)) {
    New-Item -ItemType File -Path $profilePath -Force | Out-Null
}

# Write the profile content to the profile script, overwriting if it exists
Add-Content -Path $profilePath -Value $profileContent -Force

# Output success message
Write-Host "PowerShell profile modified successfully."



# Define the content of the profile script
$profileContent = @"
function ssh {
    param (
        [string]\$userAtIp
    )

    # Path to the script that generates SSH keys
    \$generateSshKeysScript = "\$HOME\generate_ssh_keys.ps1"

    # Execute the script
    . \$generateSshKeysScript

    # Run the actual SSH command
    & "C:\Windows\System32\OpenSSH\ssh.exe" \$userAtIp
}
"@

# Path to the PowerShell profile
$profilePath = "$HOME\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1"

# Write the profile content to the profile script, overwriting if it exists
$profileContent | Out-File -FilePath $profilePath -Force -Encoding utf8

# Output success message
Write-Host "PowerShell profile modified successfully."
