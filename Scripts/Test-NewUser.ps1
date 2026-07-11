# Load Functions
. "$PSScriptRoot\Functions\Write-LabLog.ps1"
. "$PSScriptRoot\Functions\Test-EntraUserExists.ps1"
. "$PSScriptRoot\Functions\New-EntraUser.ps1"

# Import first user only
$User = Import-Csv "C:\EntraID-Lab\Data\Day1_CybersecContractor_joiners.csv" |
        Select-Object -First 1

Write-LabLog `
    -Message "Starting user creation test..." `
    -Level INFO

if (Test-EntraUserExists -UserPrincipalName $User.UserPrincipalName)
{
    Write-LabLog `
        -Message "$($User.UserPrincipalName) already exists." `
        -Level WARNING
}
else
{
    $Result = New-EntraUser -User $User

    Write-Host ""
    Write-Host "====================================" -ForegroundColor Cyan
    Write-Host "Temporary Password" -ForegroundColor Cyan
    Write-Host "====================================" -ForegroundColor Cyan
    Write-Host $Result.Password -ForegroundColor Yellow
}