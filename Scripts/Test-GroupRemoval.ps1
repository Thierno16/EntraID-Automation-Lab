Import-Module Microsoft.Graph.Authentication
Import-Module Microsoft.Graph.Users
Import-Module Microsoft.Graph.Groups

. "$PSScriptRoot\..\Functions\Import-EntraLab.ps1"

Connect-MgGraph -Scopes `
    User.ReadWrite.All,
    Group.ReadWrite.All,
    Directory.Read.All

$result = Remove-UserGroups `
    -UserPrincipalName "john.smith@SoulbyLTD.onmicrosoft.com"

$result | Format-List