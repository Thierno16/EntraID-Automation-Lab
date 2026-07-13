<#
.SYNOPSIS
Retrieves Microsoft 365 license SKUs available in the tenant.

.DESCRIPTION
Queries Microsoft Graph for all subscribed SKUs and displays
license information including total, consumed and available units.

.OUTPUTS
Microsoft.Graph.PowerShell.Models.IMicrosoftGraphSubscribedSku

.EXAMPLE
Get-LicenseSku

.NOTES
Author  : Thierno Bah
Version : 1.0
#>

function Get-LicenseSku {

    [CmdletBinding()]
    param()

    Write-LabLog `
        -Message "Retrieving Microsoft 365 license SKUs..." `
        -Level INFO

    try {

        $Licenses = Get-MgSubscribedSku | Sort-Object SkuPartNumber

        foreach ($License in $Licenses)
        {

            $Available = $License.PrepaidUnits.Enabled - $License.ConsumedUnits

            [PSCustomObject]@{

                SkuPartNumber = $License.SkuPartNumber
                SkuId         = $License.SkuId
                Total         = $License.PrepaidUnits.Enabled
                Consumed      = $License.ConsumedUnits
                Available     = $Available

            }

        }

    }
    catch {

        Write-LabLog `
            -Message "Failed to retrieve license information. $($_.Exception.Message)" `
            -Level ERROR

        throw

    }

}