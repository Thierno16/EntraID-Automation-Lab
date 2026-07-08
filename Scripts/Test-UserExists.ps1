# ==========================================
# Test-UserExists.ps1
# Purpose: Test the Test-EntraUserExists function
# ==========================================

# Load the function
. "$PSScriptRoot\Functions\Test-EntraUserExists.ps1"

# Check that we're connected to Microsoft Graph
if (-not (Get-MgContext))
{
    Write-Host "Not connected to Microsoft Graph." -ForegroundColor Red
    Write-Host "Run Connect-MgGraph first." -ForegroundColor Yellow
    return
}

# Test User Principal Name
$UPN = "john.smith@SoulbyLTD.onmicrosoft.com"

Write-Host ""
Write-Host "Checking if user exists..." -ForegroundColor Cyan
Write-Host "UPN: $UPN"
Write-Host ""

# Call the function
$Exists = Test-EntraUserExists -UserPrincipalName $UPN

# Display the result
if ($Exists)
{
    Write-Host "User exists in Entra ID." -ForegroundColor Green
}
else
{
    Write-Host "User does NOT exist." -ForegroundColor Yellow
}