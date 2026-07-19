<#
.SYNOPSIS
Loads all Entra ID Lab functions.

.DESCRIPTION
Automatically imports every PowerShell function contained in the
Functions folder, except this loader itself.

.EXAMPLE
. "$PSScriptRoot\..\Functions\Import-EntraLab.ps1"

.NOTES
Author  : Thierno Bah
Version : 1.0
#>

Get-ChildItem -Path $PSScriptRoot -Filter "*.ps1" |
Where-Object { $_.Name -ne "Import-EntraLab.ps1" } |
ForEach-Object {

    . $_.FullName

}

Write-Host ""
Write-Host "===================================================" -ForegroundColor Green
Write-Host " Microsoft Entra ID Automation Lab" -ForegroundColor Cyan
Write-Host " Functions successfully imported." -ForegroundColor Green
Write-Host " Ready for execution." -ForegroundColor Green
Write-Host "===================================================" -ForegroundColor Green