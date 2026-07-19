function Revoke-UserSessions {

<#
.SYNOPSIS
Revokes all active Microsoft Entra ID user sessions.

.DESCRIPTION
Revokes all refresh tokens for a user, forcing reauthentication
on all connected devices and applications.

.PARAMETER UserPrincipalName
The User Principal Name (UPN) of the user.

.EXAMPLE
Revoke-UserSessions -UserPrincipalName "john.smith@contoso.com"

.NOTES
Author  : Thierno Bah
Project : Project 5 - Automated User Offboarding
Version : 1.0
#>

    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string]$UserPrincipalName
    )

    try {

        Write-LabLog "Searching user: $UserPrincipalName"

        $User = Get-MgUser `
            -UserId $UserPrincipalName `
            -Property Id,DisplayName,UserPrincipalName `
            -ErrorAction Stop

        Write-LabLog "Revoking all active user sessions..."

        Revoke-MgUserSignInSession `
            -UserId $User.Id `
            -ErrorAction Stop | Out-Null

        Write-LabLog "User sessions successfully revoked."

        return [PSCustomObject]@{

            DisplayName       = $User.DisplayName
            UserPrincipalName = $User.UserPrincipalName
            Action            = "Revoke Sessions"
            Status            = "Success"
            Message           = "All user sessions have been revoked."
            Timestamp         = Get-Date

        }

    }
    catch {

        Write-LabLog "Session revocation failed: $($_.Exception.Message)"

        return [PSCustomObject]@{

            DisplayName       = ""
            UserPrincipalName = $UserPrincipalName
            Action            = "Revoke Sessions"
            Status            = "Failed"
            Message           = $_.Exception.Message
            Timestamp         = Get-Date

        }

    }

}