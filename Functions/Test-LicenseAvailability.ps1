<#
.SYNOPSIS
Checks whether a Microsoft 365 license has available units.

.DESCRIPTION
Retrieves a Microsoft 365 SKU by its SkuPartNumber and determines
whether any licenses are available for assignment.

.PARAMETER SkuPartNumber
Microsoft 365 SKU Part Number.

.OUTPUTS
PSCustomObject

.EXAMPLE
Test-LicenseAvailability `
    -SkuPartNumber "Office_365_V0_Teams_Bundle_Business_Premium"

.NOTES
Author  : Thierno Bah
Version : 1.1
#>

function Test-LicenseAvailability {

    [CmdletBinding()]
    param(

        [Parameter(Mandatory)]
        [string]$SkuPartNumber

    )

    try {

        Write-LabLog `
            -Message "Checking license availability for '$SkuPartNumber'..." `
            -Level INFO

        # Retrieve all licenses
        $Licenses = Get-MgSubscribedSku

        # Find the requested SKU
        $License = $Licenses | Where-Object {
            $_.SkuPartNumber.Trim() -eq $SkuPartNumber.Trim()
        }

        if (-not $License) {

            throw "License SKU '$SkuPartNumber' was not found."

        }

        $Available = $License.PrepaidUnits.Enabled - $License.ConsumedUnits

        return [PSCustomObject]@{

            SkuPartNumber = $License.SkuPartNumber
            SkuId         = $License.SkuId
            Total         = $License.PrepaidUnits.Enabled
            Consumed      = $License.ConsumedUnits
            Available     = $Available
            IsAvailable   = ($Available -gt 0)

        }

    }
    catch {

        Write-LabLog `
            -Message $_.Exception.Message `
            -Level ERROR

        throw

    }

}