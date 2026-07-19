<#
.SYNOPSIS
Performs bulk Microsoft Entra ID user offboarding.

.DESCRIPTION
Reads a CSV file containing user UPNs and performs
the complete offboarding process for each user.

.NOTES
Author  : Thierno Bah
Project : Project 5 - Automated User Offboarding
Version : 1.1
#>

[CmdletBinding()]
param(

    [string]$CsvPath = "$PSScriptRoot\..\Data\OffboardingUsers.csv"

)

Import-Module Microsoft.Graph.Authentication
Import-Module Microsoft.Graph.Users
Import-Module Microsoft.Graph.Groups

. "$PSScriptRoot\..\Functions\Import-EntraLab.ps1"

Connect-MgGraph -Scopes `
    User.ReadWrite.All,
    Group.ReadWrite.All,
    Directory.Read.All

if (!(Test-Path $CsvPath)) {

    Write-Error "CSV file not found: $CsvPath"
    return

}

$Users = Import-Csv $CsvPath

if ($Users.Count -eq 0) {

    Write-Error "The CSV file is empty."
    return

}

if (-not ($Users[0].PSObject.Properties.Name -contains "UserPrincipalName")) {

    Write-Error "The CSV file must contain a 'UserPrincipalName' column."
    return

}

Write-Host ""
Write-Host "Users imported: $($Users.Count)" -ForegroundColor Green
Write-Host ""

# Master collection for all users
$AllResults = @()

foreach ($User in $Users) {

    if ([string]::IsNullOrWhiteSpace($User.UserPrincipalName)) {

        Write-Warning "Skipping row because UserPrincipalName is empty."

        continue

    }

    Write-Host ""
    Write-Host "========================================" -ForegroundColor Cyan
    Write-Host "Processing: $($User.UserPrincipalName)" -ForegroundColor Cyan
    Write-Host "========================================" -ForegroundColor Cyan
    Write-Host ""

    $Results = @()

    $Results += Disable-EntraUser `
        -UserPrincipalName $User.UserPrincipalName

    $Results += Remove-UserLicenses `
        -UserPrincipalName $User.UserPrincipalName

    $Results += Remove-UserGroups `
        -UserPrincipalName $User.UserPrincipalName

    $Results += Revoke-UserSessions `
        -UserPrincipalName $User.UserPrincipalName

    # Add this user's results to the consolidated report
    $AllResults += $Results

    $Results |
        Select-Object Action, Status |
        Format-Table -AutoSize

}

Write-Host ""
Write-Host "Exporting consolidated report..." -ForegroundColor Yellow

$Report = Export-OffboardingReport `
    -Results $AllResults

Write-Host ""
Write-Host "========================================" -ForegroundColor Green
Write-Host "Bulk Offboarding Completed Successfully" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Green

Write-Host ""
Write-Host "Users Processed : $($Users.Count)" -ForegroundColor Cyan
Write-Host "Report Exported : $Report" -ForegroundColor Cyan
Write-Host ""