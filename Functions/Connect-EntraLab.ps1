<#
.SYNOPSIS
Connects to Microsoft Graph.

.DESCRIPTION
Creates a Microsoft Graph session using delegated authentication.
If a session already exists, it reuses the existing connection.

.EXAMPLE
Connect-EntraLab

.NOTES
Author  : Thierno Bah
Version : 1.1
#>

function Connect-EntraLab {

    [CmdletBinding()]
    param()

    try {

        # Check if already connected
        $Context = Get-MgContext

        if ($null -ne $Context) {

            Write-LabLog `
                -Message "Already connected to tenant '$($Context.TenantId)'." `
                -Level INFO

            return $Context

        }

        Write-LabLog `
            -Message "Connecting to Microsoft Graph..." `
            -Level INFO

        Connect-MgGraph `
            -Scopes @(
                "User.ReadWrite.All",
                "Group.ReadWrite.All",
                "Directory.ReadWrite.All"
            )

        $Context = Get-MgContext

        Write-LabLog `
            -Message "Connected successfully to tenant '$($Context.TenantId)'." `
            -Level SUCCESS

        return $Context

    }
    catch {

        Write-LabLog `
            -Message "Graph connection failed: $($_.Exception.Message)" `
            -Level ERROR

        throw

    }

}