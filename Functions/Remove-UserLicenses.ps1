function Remove-UserLicenses {

<#
.SYNOPSIS
Removes all Microsoft 365 licenses assigned to a user.

.DESCRIPTION
Retrieves all assigned licenses for a Microsoft Entra ID user and removes
them using Microsoft Graph.

.PARAMETER UserPrincipalName
The User Principal Name (UPN) of the user.

.EXAMPLE
Remove-UserLicenses -UserPrincipalName "john.smith@contoso.com"

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
            -Property Id,DisplayName,UserPrincipalName,AssignedLicenses `
            -ErrorAction Stop

        if ($User.AssignedLicenses.Count -eq 0) {

            Write-LabLog "No licenses assigned."

            return [PSCustomObject]@{

                DisplayName       = $User.DisplayName
                UserPrincipalName = $User.UserPrincipalName
                Action            = "Remove Licenses"
                Status            = "No Licenses"
                Message           = "User has no assigned licenses."
                Timestamp         = Get-Date

            }

        }

        $SkuIds = $User.AssignedLicenses.SkuId

        Set-MgUserLicense `
            -UserId $User.Id `
            -AddLicenses @() `
            -RemoveLicenses $SkuIds `
            -ErrorAction Stop | Out-Null

        Write-LabLog "Licenses removed successfully."

        return [PSCustomObject]@{

            DisplayName       = $User.DisplayName
            UserPrincipalName = $User.UserPrincipalName
            Action            = "Remove Licenses"
            Status            = "Success"
            Message           = "$($SkuIds.Count) license(s) removed."
            Timestamp         = Get-Date

        }

    }
    catch {

        Write-LabLog "License removal failed: $($_.Exception.Message)"

        return [PSCustomObject]@{

            DisplayName       = ""
            UserPrincipalName = $UserPrincipalName
            Action            = "Remove Licenses"
            Status            = "Failed"
            Message           = $_.Exception.Message
            Timestamp         = Get-Date

        }

    }

}