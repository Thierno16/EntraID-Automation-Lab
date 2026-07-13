<#
.SYNOPSIS
Tests Microsoft 365 license discovery.
#>

. "$PSScriptRoot\..\Functions\Import-EntraLab.ps1"

Connect-EntraLab | Out-Null

Write-Host ""
Write-Host "==========================================" -ForegroundColor Cyan
Write-Host "      MICROSOFT 365 LICENSES" -ForegroundColor Cyan
Write-Host "==========================================" -ForegroundColor Cyan
Write-Host ""

Get-LicenseSku | Format-Table -AutoSize