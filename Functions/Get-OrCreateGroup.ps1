function Get-OrCreateGroup {

    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [string]$GroupName
    )

    Write-LabLog -Message "Checking group '$GroupName'..."

    # Look for an existing security group
    $Group = Get-MgGroup -Filter "displayName eq '$GroupName'" -ErrorAction SilentlyContinue

    if ($Group)
    {
        Write-LabLog `
            -Message "Group '$GroupName' already exists." `
            -Level INFO

        return $Group
    }

    Write-LabLog `
        -Message "Group '$GroupName' does not exist. Creating..." `
        -Level WARNING

    try
    {
        $MailNickname = ($GroupName -replace '\s','').ToLower()

        $Group = New-MgGroup `
            -DisplayName $GroupName `
            -MailEnabled:$false `
            -MailNickname $MailNickname `
            -SecurityEnabled

        Write-LabLog `
            -Message "Group '$GroupName' created successfully." `
            -Level SUCCESS

        return $Group
    }
    catch
    {
        Write-LabLog `
            -Message "Failed to create group '$GroupName': $($_.Exception.Message)" `
            -Level ERROR

        throw
    }
}