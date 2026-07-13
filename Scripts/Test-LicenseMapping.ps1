<#
.SYNOPSIS
Tests department license mapping.
#>

. "$PSScriptRoot\..\Functions\Import-EntraLab.ps1"

$Departments = @(
    "IT",
    "SECURITY",
    "FINANCE",
    "HR"
)

Write-Host ""
Write-Host "==========================================" -ForegroundColor Cyan
Write-Host "      LICENSE MAPPING TEST" -ForegroundColor Cyan
Write-Host "==========================================" -ForegroundColor Cyan
Write-Host ""

$Results = foreach ($Department in $Departments)
{

    $License = Get-LicenseMapping `
        -Department $Department

    [PSCustomObject]@{

        Department = $Department
        License    = $License

    }

}

$Results | Format-Table -AutoSize