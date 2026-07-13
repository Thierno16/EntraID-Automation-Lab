<#
.SYNOPSIS
Tests Microsoft 365 license availability.
#>

. "$PSScriptRoot\..\Functions\Import-EntraLab.ps1"

Connect-EntraLab | Out-Null

$Sku = Get-LicenseMapping `
    -Department "IT"

Write-Host ""
Write-Host "==========================================" -ForegroundColor Cyan
Write-Host "     LICENSE AVAILABILITY TEST" -ForegroundColor Cyan
Write-Host "==========================================" -ForegroundColor Cyan
Write-Host ""

Test-LicenseAvailability `
    -SkuPartNumber $Sku |
    Format-Table -AutoSize