<#
.SYNOPSIS
Creates a provisioning result object.

.DESCRIPTION
Builds a standardized object representing the outcome of processing
a single user during onboarding, including department group assignment.

.PARAMETER DisplayName
User display name.

.PARAMETER UserPrincipalName
User's User Principal Name.

.PARAMETER Status
Provisioning status.

.PARAMETER GroupName
Department security group name.

.PARAMETER GroupStatus
Membership status.

.PARAMETER Password
Temporary password (if created).

.PARAMETER Message
Additional information.

.OUTPUTS
PSCustomObject

.EXAMPLE
Add-ProvisioningResult `
    -DisplayName "John Smith" `
    -UserPrincipalName "john.smith@contoso.com" `
    -Status Created `
    -GroupName "SG-SECURITY" `
    -GroupStatus "Added" `
    -Password "Temp!123456!" `
    -Message "User created successfully."

.NOTES
Author  : Thierno Bah
Version : 1.1
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

        [string]$GroupName = "",

        [string]$GroupStatus = "",

        [string]$Password = "",

        [string]$Message = ""

    )

    return [PSCustomObject]@{

        DisplayName       = $DisplayName
        UserPrincipalName = $UserPrincipalName
        Status            = $Status
        GroupName         = $GroupName
        GroupStatus       = $GroupStatus
        Password          = $Password
        Message           = $Message
        Timestamp         = Get-Date -Format "yyyy-MM-dd HH:mm:ss"

    }

}