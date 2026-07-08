# Track processing statistics
$Statistics = [ordered]@{
    Processed = 0
    Created   = 0
    Skipped   = 0
    Failed    = 0
}

#====================================
# Day1 Joiner
# Version 2.0
# Author: Thierno Bah
#====================================

Clear-Host

# Load Configuration
. "$PSScriptRoot\..\Config\Settings.ps1"

# Load all function files from the Functions folder
Get-ChildItem "$PSScriptRoot\Functions\*.ps1" | ForEach-Object {
    . $_.FullName
}

Write-LabLog -Message "Starting Day1 Joiner Process"

Connect-Graph

$Users = Test-JoinerCsv -CsvPath $CsvPath

$Results = @()

foreach ($User in $Users)
{
    $Results += New-EntraUser `
        -User $User `
        -Statistics $Statistics
}

$Results | Export-Csv `
    -Path ".\Reports\Day1_Onboarding_Report.csv" `
    -NoTypeInformation

Write-LabLog -Message "Onboarding Completed" -Level SUCCESS

Write-Host ""
Write-Host "========== Summary ==========" -ForegroundColor Cyan
Write-Host "Processed : $($Statistics.Processed)"
Write-Host "Created   : $($Statistics.Created)" -ForegroundColor Green
Write-Host "Skipped   : $($Statistics.Skipped)" -ForegroundColor Yellow
Write-Host "Failed    : $($Statistics.Failed)" -ForegroundColor Red