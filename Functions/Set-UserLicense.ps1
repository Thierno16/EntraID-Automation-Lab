<#
.SYNOPSIS
Assigns a Microsoft 365 license to a user.

.DESCRIPTION
Assigns the Microsoft 365 license mapped to the user's department
after verifying that licenses are available.

.PARAMETER User
Microsoft Graph user object.

.PARAMETER Department
Department name.

.OUTPUTS
String

.EXAMPLE
Set-UserLicense `
    -User $User `
    -Department "IT"

.NOTES
Author  : Thierno Bah
Version : 1.0
#>

function Set-UserLicense {

    [CmdletBinding()]
    param(

        [Parameter(Mandatory)]
        $User,

        [Parameter(Mandatory)]
        [string]$Department

    )

    try {

        Write-LabLog `
            -Message "Assigning Microsoft 365 license to '$($User.UserPrincipalName)'..." `
            -Level INFO

        #---------------------------------------------
        # Get mapped license
        #---------------------------------------------

        $SkuPartNumber = Get-LicenseMapping `
            -Department $Department

        #---------------------------------------------
        # Check license availability
        #---------------------------------------------

        $License = Test-LicenseAvailability `
            -SkuPartNumber $SkuPartNumber

        if (-not $License.IsAvailable) {

            Write-LabLog `
                -Message "No available licenses for '$SkuPartNumber'." `
                -Level WARNING

            return "NoLicenseAvailable"

        }

        #---------------------------------------------
        # Check existing licenses
        #---------------------------------------------

        $AssignedLicenses = Get-MgUserLicenseDetail `
            -UserId $User.Id

        if ($AssignedLicenses.SkuId -contains $License.SkuId) {

            Write-LabLog `
                -Message "$($User.UserPrincipalName) already has the license assigned." `
                -Level INFO

            return "AlreadyAssigned"

        }

        #---------------------------------------------
        # Assign license
        #---------------------------------------------

        Set-MgUserLicense `
            -UserId $User.Id `
            -AddLicenses @(
                @{
                    SkuId = $License.SkuId
                }
            ) `
            -RemoveLicenses @() | Out-Null

        Write-LabLog `
            -Message "License assigned successfully to '$($User.UserPrincipalName)'." `
            -Level SUCCESS

        return "Assigned"

    }
    catch {

        Write-LabLog `
            -Message $_.Exception.Message `
            -Level ERROR

        return "Failed"

    }

}