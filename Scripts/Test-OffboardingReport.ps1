Import-Module Microsoft.Graph.Authentication
Import-Module Microsoft.Graph.Users
Import-Module Microsoft.Graph.Groups

. "$PSScriptRoot\..\Functions\Import-EntraLab.ps1"

Connect-MgGraph -Scopes `
    User.ReadWrite.All,
    Group.ReadWrite.All

$Results = @()

$Results += Disable-EntraUser `
    -UserPrincipalName "john.smith@SoulbyLTD.onmicrosoft.com"

$Results += Remove-UserLicenses `
    -UserPrincipalName "john.smith@SoulbyLTD.onmicrosoft.com"

$Results += Remove-UserGroups `
    -UserPrincipalName "john.smith@SoulbyLTD.onmicrosoft.com"

$Results += Revoke-UserSessions `
    -UserPrincipalName "john.smith@SoulbyLTD.onmicrosoft.com"

$Report = Export-OffboardingReport `
    -Results $Results

Write-Host ""
Write-Host "Report exported to:" -ForegroundColor Green
Write-Host $Report