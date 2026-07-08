function Add-UserToDepartment {

    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        $User,

        [Parameter(Mandatory)]
        $Group
    )

    try
    {
        New-MgGroupMember `
            -GroupId $Group.Id `
            -DirectoryObjectId $User.Id

        Write-LabLog `
            -Message "$($User.DisplayName) added to '$($Group.DisplayName)'." `
            -Level SUCCESS
    }
    catch
    {
        Write-LabLog `
            -Message "Failed to add $($User.DisplayName) to '$($Group.DisplayName)': $($_.Exception.Message)" `
            -Level ERROR
    }
}