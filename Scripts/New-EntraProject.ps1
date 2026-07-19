<#
.SYNOPSIS
Creates a new Microsoft Entra ID automation project.

.DESCRIPTION
Generates the folder structure and starter files for a new
Microsoft Entra ID automation project.

.NOTES
Author  : Thierno Bah
Version : 1.0
#>

[CmdletBinding()]
param(

    [Parameter(Mandatory)]
    [string]$ProjectName,

    [Parameter(Mandatory)]
    [string]$Version

)

$RepositoryRoot = Split-Path -Parent $PSScriptRoot
$ProjectRoot    = Join-Path $RepositoryRoot $ProjectName

Write-Host ""
Write-Host "=============================================" -ForegroundColor Cyan
Write-Host " Microsoft Entra Project Generator" -ForegroundColor Cyan
Write-Host "=============================================" -ForegroundColor Cyan
Write-Host ""

#--------------------------------------------------------
# Create Project Folder
#--------------------------------------------------------

if (!(Test-Path $ProjectRoot)) {

    New-Item -ItemType Directory -Path $ProjectRoot | Out-Null

    Write-Host "[Created] $ProjectName" -ForegroundColor Green

}
else {

    Write-Host "[Exists ] $ProjectName" -ForegroundColor Yellow

}

#--------------------------------------------------------
# Folder Structure
#--------------------------------------------------------

$Folders = @(
    "Config",
    "Data",
    "Docs",
    "Docs\Images",
    "Functions",
    "Logs",
    "Reports",
    "Scripts",
    "Templates",
    "Tests"
)

foreach ($Folder in $Folders){

    $Path = Join-Path $ProjectRoot $Folder

    if (!(Test-Path $Path)){

        New-Item -ItemType Directory -Path $Path | Out-Null

        Write-Host "   + $Folder"

    }

}

Write-Host ""
Write-Host "Project structure created successfully." -ForegroundColor Green