<#
.SYNOPSIS
Tests Microsoft 365 license assignment.
#>

. "$PSScriptRoot\..\Functions\Import-EntraLab.ps1"

Connect-EntraLab | Out-Null

# Existing user in your lab
$User = Get-MgUser `
    -UserId "john.smith@SoulbyLTD.onmicrosoft.com"

$result = Set-UserLicense `
    -User $User `
    -Department "IT"

Write-Host ""
Write-Host "==========================================" -ForegroundColor Cyan
Write-Host "      LICENSE ASSIGNMENT RESULT" -ForegroundColor Cyan
Write-Host "==========================================" -ForegroundColor Cyan
Write-Host ""

Write-Host "User      : $($User.UserPrincipalName)"
Write-Host "Department: IT"
Write-Host "Result    : $result" -ForegroundColor Green