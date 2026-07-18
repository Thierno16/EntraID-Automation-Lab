Import-Module Microsoft.Graph.Users
Import-Module Microsoft.Graph.Authentication

. "$PSScriptRoot\..\Functions\Import-EntraLab.ps1"

Connect-MgGraph -Scopes User.ReadWrite.All

Disable-EntraUser -UserPrincipalName "test.user@yourtenant.onmicrosoft.com"