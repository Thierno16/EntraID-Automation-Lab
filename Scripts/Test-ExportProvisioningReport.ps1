# Load Functions

. "$PSScriptRoot\Functions\Write-LabLog.ps1"
. "$PSScriptRoot\Functions\Add-ProvisioningResult.ps1"
. "$PSScriptRoot\Functions\Export-ProvisioningReport.ps1"

# Create sample results

$Results = @()

$Results += Add-ProvisioningResult `
    -DisplayName "John Smith" `
    -UserPrincipalName "john.smith@SoulbyLTD.onmicrosoft.com" `
    -Status Exists `
    -Message "User already exists."

$Results += Add-ProvisioningResult `
    -DisplayName "David Miller" `
    -UserPrincipalName "david.miller@SoulbyLTD.onmicrosoft.com" `
    -Status Created `
    -Password "Temp!654321!" `
    -Message "User created successfully."

# Export report

$Report = Export-ProvisioningReport `
    -Results $Results

Write-Host ""
Write-Host "====================================" -ForegroundColor Cyan
Write-Host "Report Created Successfully" -ForegroundColor Green
Write-Host "====================================" -ForegroundColor Cyan
Write-Host $Report -ForegroundColor Yellow