<#
.SYNOPSIS
Creates a provisioning result object.

.DESCRIPTION
Builds a standardized object representing the outcome of processing
a single user during onboarding.

.PARAMETER DisplayName
User display name.

.PARAMETER UserPrincipalName
User's UPN.

.PARAMETER Status
Provisioning status.

.PARAMETER Password
Temporary password (if created).

.PARAMETER Message
Additional information.

.EXAMPLE
Add-ProvisioningResult `
    -DisplayName "John Smith" `
    -UserPrincipalName "john.smith@contoso.com" `
    -Status Created `
    -Password "Temp!123456!" `
    -Message "User created successfully."

.NOTES
Author  : Thierno Bah
Version : 1.0
#>

function Add-ProvisioningResult {

    [CmdletBinding()]
    param(

        [Parameter(Mandatory)]
        [string]$DisplayName,

        [Parameter(Mandatory)]
        [string]$UserPrincipalName,

        [Parameter(Mandatory)]
        [ValidateSet("Created","Exists","Failed")]
        [string]$Status,

        [string]$Password = "",

        [string]$Message = ""

    )

    return [PSCustomObject]@{

        DisplayName       = $DisplayName
        UserPrincipalName = $UserPrincipalName
        Status            = $Status
        Password          = $Password
        Message           = $Message
        Timestamp         = Get-Date -Format "yyyy-MM-dd HH:mm:ss"

    }

}