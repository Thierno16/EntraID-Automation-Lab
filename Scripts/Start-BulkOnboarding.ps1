<#
.SYNOPSIS
Bulk onboarding users into Microsoft Entra ID.

.DESCRIPTION
Reads users from a CSV file, validates the data,
creates missing users, generates logs and exports
a provisioning report.

.NOTES
Author  : Thierno Bah
Version : 1.1
#>

[CmdletBinding()]
param(

    [string]$CsvPath = (
        Join-Path `
            $PSScriptRoot `
            "..\Data\Day1_CybersecContractor_joiners.csv"
    )

)

#-------------------------------------------------
# Load Entra Lab Toolkit
#-------------------------------------------------

. "$PSScriptRoot\..\Functions\Import-EntraLab.ps1"

#-------------------------------------------------
# Connect to Microsoft Graph
#-------------------------------------------------

Connect-EntraLab | Out-Null

#-------------------------------------------------
# Validate CSV
#-------------------------------------------------

$Users = Test-JoinerCsv `
    -CsvPath $CsvPath

Write-LabLog `
    -Message "$($Users.Count) users ready for processing." `
    -Level INFO

#-------------------------------------------------
# Prepare Results Collection
#-------------------------------------------------

$Results = @()

#-------------------------------------------------
# Process Users
#-------------------------------------------------

foreach ($User in $Users)
{

    Write-LabLog `
        -Message "Processing $($User.UserPrincipalName)..." `
        -Level INFO

    if (Test-EntraUserExists -UserPrincipalName $User.UserPrincipalName)
    {

        Write-LabLog `
            -Message "$($User.UserPrincipalName) already exists." `
            -Level WARNING

        $Results += Add-ProvisioningResult `
            -DisplayName $User.DisplayName `
            -UserPrincipalName $User.UserPrincipalName `
            -Status Exists `
            -Message "User already exists."

    }
    else
    {

        try
        {

            $NewUser = New-EntraUser `
                -User $User

            $Results += Add-ProvisioningResult `
                -DisplayName $User.DisplayName `
                -UserPrincipalName $User.UserPrincipalName `
                -Status Created `
                -Password $NewUser.Password `
                -Message "User created successfully."

        }
        catch
        {

            $Results += Add-ProvisioningResult `
                -DisplayName $User.DisplayName `
                -UserPrincipalName $User.UserPrincipalName `
                -Status Failed `
                -Message $_.Exception.Message

        }

    }

}

#-------------------------------------------------
# Processing Completed
#-------------------------------------------------

Write-LabLog `
    -Message "Bulk onboarding processing completed." `
    -Level SUCCESS

#-------------------------------------------------
# Export Provisioning Report
#-------------------------------------------------

$ReportPath = Export-ProvisioningReport `
    -Results $Results `
    -Path (
        Join-Path `
            $PSScriptRoot `
            "..\Reports\ProvisioningReport_$(Get-Date -Format 'yyyyMMdd_HHmmss').csv"
    )

#-------------------------------------------------
# Display Summary
#-------------------------------------------------

$Created  = ($Results | Where-Object Status -eq "Created").Count
$Existing = ($Results | Where-Object Status -eq "Exists").Count
$Failed   = ($Results | Where-Object Status -eq "Failed").Count

Write-Host ""
Write-Host "==================================================" -ForegroundColor Cyan
Write-Host "             BULK ONBOARDING SUMMARY" -ForegroundColor Cyan
Write-Host "==================================================" -ForegroundColor Cyan
Write-Host ""

Write-Host ("Users Processed : {0}" -f $Results.Count)
Write-Host ("Created         : {0}" -f $Created) -ForegroundColor Green
Write-Host ("Already Exists  : {0}" -f $Existing) -ForegroundColor Yellow
Write-Host ("Failed          : {0}" -f $Failed) -ForegroundColor Red

Write-Host ""
Write-Host ("Report          : {0}" -f $ReportPath) -ForegroundColor Cyan
Write-Host ""
Write-Host "==================================================" -ForegroundColor Cyan