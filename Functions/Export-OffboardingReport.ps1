function Export-OffboardingReport {

<#
.SYNOPSIS
Exports the user offboarding results to a CSV report.

.DESCRIPTION
Exports the collected offboarding results to the Reports folder.

.PARAMETER Results
Collection of PSCustomObjects returned by the offboarding functions.

.PARAMETER Path
Destination CSV file.

.EXAMPLE
Export-OffboardingReport -Results $Results

.NOTES
Author  : Thierno Bah
Project : Project 5 - Automated User Offboarding
Version : 1.0
#>

    [CmdletBinding()]
    param(

        [Parameter(Mandatory)]
        [array]$Results,

        [string]$Path = "$PSScriptRoot\..\Reports\OffboardingReport.csv"

    )

    try {

        Write-LabLog "Exporting offboarding report..."

        $Results |
            Export-Csv `
                -Path $Path `
                -NoTypeInformation `
                -Encoding UTF8

        Write-LabLog "Report exported successfully."

        return $Path

    }
    catch {

        Write-LabLog "Report export failed: $($_.Exception.Message)"

        throw

    }

}