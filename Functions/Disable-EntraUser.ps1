function Disable-EntraUser {

<#
.SYNOPSIS
Disables a Microsoft Entra ID user account.

.DESCRIPTION
Retrieves a Microsoft Entra ID user and disables the account.
If the account is already disabled, no action is taken.

.PARAMETER UserPrincipalName
User Principal Name of the user to disable.

.EXAMPLE
Disable-EntraUser -UserPrincipalName "john.smith@contoso.onmicrosoft.com"

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
            -Property Id,DisplayName,UserPrincipalName,AccountEnabled `
            -ErrorAction Stop

        if (-not $User.AccountEnabled) {

            Write-LabLog "User is already disabled."

            return [PSCustomObject]@{

                DisplayName       = $User.DisplayName
                UserPrincipalName = $User.UserPrincipalName
                Action            = "Disable Account"
                Status            = "Already Disabled"
                Message           = "Account already disabled."
                Timestamp         = Get-Date

            }

        }

        Update-MgUser `
            -UserId $User.Id `
            -AccountEnabled:$false `
            -ErrorAction Stop

        Write-LabLog "Account disabled successfully."

        return [PSCustomObject]@{

            DisplayName       = $User.DisplayName
            UserPrincipalName = $User.UserPrincipalName
            Action            = "Disable Account"
            Status            = "Success"
            Message           = "Account disabled successfully."
            Timestamp         = Get-Date

        }

    }
    catch {

        Write-LabLog "Disable account failed: $($_.Exception.Message)"

        return [PSCustomObject]@{

            DisplayName       = ""
            UserPrincipalName = $UserPrincipalName
            Action            = "Disable Account"
            Status            = "Failed"
            Message           = $_.Exception.Message
            Timestamp         = Get-Date

        }

    }

}