# Define the credentials
$username = "your_username"
$password = ConvertTo-SecureString "your_password" -AsPlainText -Force
$credential = New-Object System.Management.Automation.PSCredential($username, $password)

# URL of the executable to download
$url = "http://example.com/downloaded.exe"

# Path to save the downloaded file
$outputFile = "downloaded.exe"

# Download the file with authentication
Invoke-WebRequest -Uri $url -OutFile $outputFile -Credential $credential
