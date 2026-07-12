# Load Toolkit
. "$PSScriptRoot\..\Functions\Import-EntraLab.ps1"

# Connect to Graph
Connect-EntraLab | Out-Null

# Test Group
$Group = Get-OrCreateGroup `
    -Department "Security"

Write-Host ""
Write-Host "==================================" -ForegroundColor Cyan
Write-Host "GROUP INFORMATION" -ForegroundColor Cyan
Write-Host "==================================" -ForegroundColor Cyan

$Group | Select-Object `
    DisplayName,
    Id,
    SecurityEnabled