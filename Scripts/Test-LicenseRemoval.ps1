Import-Module Microsoft.Graph.Authentication
Import-Module Microsoft.Graph.Users

. "$PSScriptRoot\..\Functions\Import-EntraLab.ps1"

Connect-MgGraph -Scopes User.ReadWrite.All

$result = Remove-UserLicenses `
    -UserPrincipalName "john.smith@SoulbyLTD.onmicrosoft.com"

$result | Format-List