<#
.SYNOPSIS
Retrieves or creates a Microsoft Entra ID security group.

.DESCRIPTION
Checks whether a security group exists for the specified department.
If the group does not exist, it is created automatically.

.PARAMETER Department
Department name used to determine the security group.

.OUTPUTS
Microsoft.Graph.PowerShell.Models.IMicrosoftGraphGroup

.EXAMPLE
$Group = Get-OrCreateGroup -Department "Security"

.NOTES
Author  : Thierno Bah
Version : 1.0
#>

function Get-OrCreateGroup {

    [CmdletBinding()]
    param(

        [Parameter(Mandatory)]
        [string]$Department

    )

    try {

        #-----------------------------------------
        # Build Group Name
        #-----------------------------------------

        $GroupName = "SG-$($Department.ToUpper())"

        Write-LabLog `
            -Message "Checking for group '$GroupName'..." `
            -Level INFO

        #-----------------------------------------
        # Search Existing Group
        #-----------------------------------------

        $Group = Get-MgGroup `
            -Filter "displayName eq '$GroupName'" `
            -ConsistencyLevel eventual

        if ($Group)
        {

            Write-LabLog `
                -Message "Group '$GroupName' already exists." `
                -Level SUCCESS

            return $Group

        }

        #-----------------------------------------
        # Create Group
        #-----------------------------------------

        Write-LabLog `
            -Message "Creating group '$GroupName'..." `
            -Level INFO

        $MailNickname = ($GroupName -replace '[^A-Za-z0-9]', '')

        $Group = New-MgGroup `
            -DisplayName $GroupName `
            -MailEnabled:$false `
            -MailNickname $MailNickname `
            -SecurityEnabled:$true `
            -Description "Department Security Group for $Department"

        Write-LabLog `
            -Message "Group '$GroupName' created successfully." `
            -Level SUCCESS

        return $Group

    }
    catch {

        Write-LabLog `
            -Message "Failed to create or retrieve group '$GroupName'. Error: $($_.Exception.Message)" `
            -Level ERROR

        throw

    }

}