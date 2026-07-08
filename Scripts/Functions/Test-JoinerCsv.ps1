function Test-JoinerCsv {

    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [string]$CsvPath
    )

    Write-LabLog -Message "Reading CSV..."

    if (!(Test-Path $CsvPath)) {
        throw "CSV file not found: $CsvPath"
    }

    $Users = Import-Csv $CsvPath

    if ($Users.Count -eq 0) {
        throw "CSV contains no users."
    }

    # Check duplicate EmployeeId
    $DuplicateEmployeeIds = $Users |
        Group-Object EmployeeId |
        Where-Object Count -gt 1

    if ($DuplicateEmployeeIds) {

        foreach ($Duplicate in $DuplicateEmployeeIds) {

            Write-LabLog `
                -Message "Duplicate EmployeeId found: $($Duplicate.Name)" `
                -Level ERROR

        }

        throw "Duplicate Employee IDs detected."
    }

    # Check duplicate UPN
    $DuplicateUPNs = $Users |
        Group-Object UserPrincipalName |
        Where-Object Count -gt 1

    if ($DuplicateUPNs) {

        foreach ($Duplicate in $DuplicateUPNs) {

            Write-LabLog `
                -Message "Duplicate UserPrincipalName found: $($Duplicate.Name)" `
                -Level ERROR

        }

        throw "Duplicate UserPrincipalNames detected."
    }

    Write-LabLog `
        -Message "CSV validation passed. $($Users.Count) users found." `
        -Level SUCCESS

    return $Users
}