<#
.SYNOPSIS
Retrieves the Microsoft 365 license assigned to a department.

.DESCRIPTION
Reads the LicenseMapping.json configuration file and returns
the Microsoft 365 SKU associated with the specified department.

.PARAMETER Department
Department name.

.OUTPUTS
String

.EXAMPLE
Get-LicenseMapping -Department "IT"

.NOTES
Author  : Thierno Bah
Version : 1.0
#>

function Get-LicenseMapping {

    [CmdletBinding()]
    param(

        [Parameter(Mandatory)]
        [string]$Department

    )

    try {

        $ConfigPath = Join-Path `
            $PSScriptRoot `
            "..\Config\LicenseMapping.json"

        if (!(Test-Path $ConfigPath)) {

            throw "License mapping file not found."

        }

        $Mapping = Get-Content `
            -Path $ConfigPath `
            -Raw |
            ConvertFrom-Json

        $Department = $Department.ToUpper()

        if ($Mapping.PSObject.Properties.Name -contains $Department) {

            return $Mapping.$Department.SkuPartNumber

        }

        throw "No license mapping found for department '$Department'."

    }
    catch {

        Write-LabLog `
            -Message $_.Exception.Message `
            -Level ERROR

        throw

    }

}