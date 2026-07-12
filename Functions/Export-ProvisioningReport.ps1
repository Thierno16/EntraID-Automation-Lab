<#
.SYNOPSIS
Exports the provisioning results to a CSV report.

.DESCRIPTION
Exports all provisioning results collected during the onboarding
process into a CSV report.

.PARAMETER Results
Collection of provisioning result objects.

.PARAMETER Path
Optional full path to the report file.
If omitted, a timestamped report is created in C:\EntraID-Lab\Reports.

.EXAMPLE
Export-ProvisioningReport -Results $Results

.EXAMPLE
Export-ProvisioningReport -Results $Results -Path "C:\Reports\Report.csv"

.NOTES
Author  : Thierno Bah
Version : 1.1
#>

function Export-ProvisioningReport {

    [CmdletBinding()]
    param(

        [Parameter(Mandatory)]
        [array]$Results,

        [string]$Path

    )

    try {

        #-------------------------------------------------
        # Build default report path if not supplied
        #-------------------------------------------------

        if ([string]::IsNullOrWhiteSpace($Path))
        {
            $ReportFolder = "C:\EntraID-Lab\Reports"

            if (!(Test-Path $ReportFolder))
            {
                New-Item `
                    -ItemType Directory `
                    -Path $ReportFolder `
                    -Force | Out-Null
            }

            $Timestamp = Get-Date -Format "yyyyMMdd_HHmmss"

            $Path = Join-Path `
                $ReportFolder `
                "ProvisioningReport_$Timestamp.csv"
        }

        else
        {
            $Folder = Split-Path $Path

            if (!(Test-Path $Folder))
            {
                New-Item `
                    -ItemType Directory `
                    -Path $Folder `
                    -Force | Out-Null
            }
        }

        #-------------------------------------------------
        # Export CSV
        #-------------------------------------------------

        $Results | Export-Csv `
            -Path $Path `
            -NoTypeInformation `
            -Encoding UTF8

        Write-LabLog `
            -Message "Provisioning report exported to '$Path'." `
            -Level SUCCESS

        return $Path

    }
    catch {

        Write-LabLog `
            -Message "Failed to export provisioning report. Error: $($_.Exception.Message)" `
            -Level ERROR

        throw

    }

}