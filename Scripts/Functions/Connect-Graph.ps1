<#
.SYNOPSIS
Connects to Microsoft Graph.

.DESCRIPTION
Creates a Microsoft Graph session using delegated authentication.
If a valid session already exists, it reuses the existing connection.
The function also verifies that all required Microsoft Graph scopes are available.

.EXAMPLE
Connect-Graph

.NOTES
Author  : Thierno Bah
Version : 1.0
#>

function Connect-Graph {

    [CmdletBinding()]
    param()

    Write-LabLog `
        -Message "Connecting to Microsoft Graph..." `
        -Level INFO

    try {

        #-------------------------------------------------
        # Check if already connected
        #-------------------------------------------------

        $Context = Get-MgContext

        if ($null -eq $Context) {

            Connect-MgGraph `
                -Scopes @(
                    "User.ReadWrite.All",
                    "Group.ReadWrite.All",
                    "Directory.ReadWrite.All"
                )

            $Context = Get-MgContext
        }

        #-------------------------------------------------
        # Verify required scopes
        #-------------------------------------------------

        $RequiredScopes = @(
            "User.ReadWrite.All",
            "Group.ReadWrite.All",
            "Directory.ReadWrite.All"
        )

        foreach ($Scope in $RequiredScopes) {

            if ($Scope -notin $Context.Scopes) {

                throw "Missing required Microsoft Graph permission: $Scope"

            }
        }

        #-------------------------------------------------
        # Log successful connection
        #-------------------------------------------------

        Write-LabLog `
            -Message "Connected to tenant '$($Context.TenantId)' as '$($Context.Account)'." `
            -Level SUCCESS

    }
    catch {

        Write-LabLog `
            -Message "Microsoft Graph connection failed. Error: $($_.Exception.Message)" `
            -Level ERROR

        throw

    }

}