<#
.SYNOPSIS
Performs a complete Microsoft Entra ID user offboarding.

.DESCRIPTION
Executes all Project 5 offboarding functions in sequence:
- Disable user account
- Remove Microsoft 365 licenses
- Remove group memberships
- Revoke user sessions
- Export offboarding report

.PARAMETER UserPrincipalName
The User Principal Name (UPN) of the user.

.EXAMPLE
.\Start-Offboarding.ps1 -UserPrincipalName "john.smith@contoso.com"

.NOTES
Author  : Thierno Bah
Project : Project 5 - Automated User Offboarding
Version : 1.0
#>

[CmdletBinding()]
param(

    [Parameter(Mandatory)]
    [ValidateNotNullOrEmpty()]
    [string]$UserPrincipalName

)

Import-Module Microsoft.Graph.Authentication
Import-Module Microsoft.Graph.Users
Import-Module Microsoft.Graph.Groups

. "$PSScriptRoot\..\Functions\Import-EntraLab.ps1"

Connect-MgGraph -Scopes `
    User.ReadWrite.All,
    Group.ReadWrite.All,
    Directory.Read.All

Write-Host ""
Write-Host "=========================================" -ForegroundColor Cyan
Write-Host " Microsoft Entra User Offboarding" -ForegroundColor Cyan
Write-Host "=========================================" -ForegroundColor Cyan
Write-Host ""

$Results = @()

$Results += Disable-EntraUser `
    -UserPrincipalName $UserPrincipalName

$Results += Remove-UserLicenses `
    -UserPrincipalName $UserPrincipalName

$Results += Remove-UserGroups `
    -UserPrincipalName $UserPrincipalName

$Results += Revoke-UserSessions `
    -UserPrincipalName $UserPrincipalName

$Report = Export-OffboardingReport `
    -Results $Results

Write-Host ""
Write-Host "=========================================" -ForegroundColor Green
Write-Host " Offboarding Completed Successfully" -ForegroundColor Green
Write-Host "=========================================" -ForegroundColor Green

Write-Host ""
Write-Host "Summary:" -ForegroundColor Yellow

$Results |
    Select-Object Action,Status |
    Format-Table -AutoSize

Write-Host ""
Write-Host "Report:" -ForegroundColor Yellow
Write-Host $Report