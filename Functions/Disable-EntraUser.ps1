function Disable-EntraUser {

<#
.SYNOPSIS
    Disables a Microsoft Entra ID user account.

.DESCRIPTION
    Retrieves a user by User Principal Name (UPN) and disables the account
    using the Microsoft Graph PowerShell SDK.

.PARAMETER UserPrincipalName
    The User Principal Name (UPN) of the user to disable.

.EXAMPLE
    Disable-EntraUser -UserPrincipalName "john.smith@contoso.com"
#>

    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string]$UserPrincipalName
    )

    try {

        $User = Get-MgUser -UserId $UserPrincipalName -ErrorAction Stop

        if (-not $User.AccountEnabled) {

            Write-Host "[INFO] User '$UserPrincipalName' is already disabled." -ForegroundColor Yellow

            return @{
                Status = "Already Disabled"
                Message = "User account is already disabled."
            }
        }

        Update-MgUser `
            -UserId $User.Id `
            -AccountEnabled:$false

        Write-Host "[SUCCESS] User '$UserPrincipalName' disabled successfully." -ForegroundColor Green

        return @{
            Status = "Success"
            Message = "User account disabled."
        }

    }
    catch {

        Write-Host "[ERROR] Failed to disable '$UserPrincipalName'." -ForegroundColor Red

        return @{
            Status = "Failed"
            Message = $_.Exception.Message
        }

    }

}