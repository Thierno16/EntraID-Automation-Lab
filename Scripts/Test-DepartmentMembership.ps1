# Load Toolkit
. "$PSScriptRoot\..\Functions\Import-EntraLab.ps1"

# Connect
Connect-EntraLab | Out-Null

# Get User
$User = Get-MgUser `
    -UserId "john.smith@SoulbyLTD.onmicrosoft.com"

# Get Group
$Group = Get-OrCreateGroup `
    -Department "Security"

# Add Membership
$result = Add-UserToDepartment `
    -User $User `
    -Group $Group

Write-Host ""
Write-Host "===============================" -ForegroundColor Cyan
Write-Host "Membership Result" -ForegroundColor Cyan
Write-Host "===============================" -ForegroundColor Cyan
Write-Host $result -ForegroundColor Green