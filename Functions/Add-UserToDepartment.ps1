<#
.SYNOPSIS
Adds a user to a department security group.

.DESCRIPTION
Checks whether the user is already a member of the specified
Microsoft Entra ID security group. If not, the user is added.

.PARAMETER User
Microsoft Entra ID user object.

.PARAMETER Group
Microsoft Entra ID security group object.

.OUTPUTS
String

.EXAMPLE
Add-UserToDepartment `
    -User $User `
    -Group $Group

.NOTES
Author  : Thierno Bah
Version : 1.0
#>

function Add-UserToDepartment {

    [CmdletBinding()]
    param(

        [Parameter(Mandatory)]
        $User,

        [Parameter(Mandatory)]
        $Group

    )

    try {

        Write-LabLog `
            -Message "Checking membership of '$($User.UserPrincipalName)' in '$($Group.DisplayName)'..." `
            -Level INFO

        #-------------------------------------------------
        # Get Current Members
        #-------------------------------------------------

        $Members = Get-MgGroupMember `
            -GroupId $Group.Id `
            -All

        $AlreadyMember = $Members.Id -contains $User.Id

        if ($AlreadyMember)
        {

            Write-LabLog `
                -Message "$($User.UserPrincipalName) is already a member of '$($Group.DisplayName)'." `
                -Level SUCCESS

            return "AlreadyMember"

        }

        #-------------------------------------------------
        # Add User
        #-------------------------------------------------

        Write-LabLog `
            -Message "Adding '$($User.UserPrincipalName)' to '$($Group.DisplayName)'..." `
            -Level INFO

        New-MgGroupMemberByRef `
            -GroupId $Group.Id `
            -BodyParameter @{
                "@odata.id" = "https://graph.microsoft.com/v1.0/directoryObjects/$($User.Id)"
            }

        Write-LabLog `
            -Message "$($User.UserPrincipalName) added to '$($Group.DisplayName)'." `
            -Level SUCCESS

        return "Added"

    }
    catch {

        Write-LabLog `
            -Message "Failed to add user to group. Error: $($_.Exception.Message)" `
            -Level ERROR

        throw

    }

}