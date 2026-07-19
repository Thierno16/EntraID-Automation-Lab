function Remove-UserGroups {

<#
.SYNOPSIS
Removes a user from eligible Microsoft Entra ID group memberships.

.DESCRIPTION
Retrieves all group memberships for a user and removes
supported group types while skipping unsupported directory objects.

.PARAMETER UserPrincipalName
The User Principal Name (UPN) of the user.

.EXAMPLE
Remove-UserGroups -UserPrincipalName "john.smith@contoso.com"

.NOTES
Author  : Thierno Bah
Project : Project 5 - Automated User Offboarding
Version : 1.0
#>

    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string]$UserPrincipalName
    )

    try {

        Write-LabLog "Searching user: $UserPrincipalName"

        $User = Get-MgUser `
            -UserId $UserPrincipalName `
            -Property Id,DisplayName,UserPrincipalName `
            -ErrorAction Stop

        Write-LabLog "Retrieving group memberships..."

        $Groups = Get-MgUserMemberOf `
            -UserId $User.Id `
            -All `
            -ErrorAction Stop

        $Processed = 0
        $Removed   = 0
        $Skipped   = 0

        foreach ($Group in $Groups) {

            $Processed++

            # Only process Microsoft Entra groups
            if ($Group.AdditionalProperties.'@odata.type' -ne '#microsoft.graph.group') {

                Write-LabLog "Skipped unsupported object."

                $Skipped++

                continue

            }

            try {

                # Retrieve the group display name
                $GroupInfo = Get-MgGroup `
                    -GroupId $Group.Id `
                    -Property DisplayName `
                    -ErrorAction SilentlyContinue

                $GroupName = if ($GroupInfo.DisplayName) {
                    $GroupInfo.DisplayName
                }
                else {
                    $Group.Id
                }

                # Remove the user from the group
                Remove-MgGroupMemberByRef `
                    -GroupId $Group.Id `
                    -DirectoryObjectId $User.Id `
                    -ErrorAction Stop

                Write-LabLog "Removed from group: $GroupName"

                $Removed++

            }
            catch {

                Write-LabLog "Failed removing from group: $GroupName"

                $Skipped++

            }

        }

        return [PSCustomObject]@{

            DisplayName       = $User.DisplayName
            UserPrincipalName = $User.UserPrincipalName
            GroupsProcessed   = $Processed
            GroupsRemoved     = $Removed
            GroupsSkipped     = $Skipped
            Action            = "Remove Groups"
            Status            = "Success"
            Message           = "Group membership cleanup completed."
            Timestamp         = Get-Date

        }

    }
    catch {

        Write-LabLog "Group cleanup failed: $($_.Exception.Message)"

        return [PSCustomObject]@{

            DisplayName       = ""
            UserPrincipalName = $UserPrincipalName
            GroupsProcessed   = 0
            GroupsRemoved     = 0
            GroupsSkipped     = 0
            Action            = "Remove Groups"
            Status            = "Failed"
            Message           = $_.Exception.Message
            Timestamp         = Get-Date

        }

    }

}