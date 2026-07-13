<#
.SYNOPSIS
Creates a provisioning result object.

.DESCRIPTION
Creates a standardized object used for onboarding reports.

.NOTES
Author  : Thierno Bah
Version : 2.0
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

        [string]$License = "",

        [string]$LicenseStatus = "",

        [string]$Password = "",

        [string]$Message = ""

    )

    [PSCustomObject]@{

        DisplayName       = $DisplayName
        UserPrincipalName = $UserPrincipalName
        Status            = $Status

        GroupName         = $GroupName
        GroupStatus       = $GroupStatus

        License           = $License
        LicenseStatus     = $LicenseStatus

        Password          = $Password
        Message           = $Message

        Timestamp         = Get-Date -Format "yyyy-MM-dd HH:mm:ss"

    }

}