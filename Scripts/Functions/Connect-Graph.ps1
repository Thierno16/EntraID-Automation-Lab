function Connect-Graph {

    [CmdletBinding()]
    param()

    Write-LabLog `
        -Message "Connecting to Microsoft Graph..."

    try {

        # Check if already connected
        $Context = Get-MgContext

        if ($null -ne $Context) {

            Write-LabLog `
                -Message "Already connected to tenant '$($Context.TenantId)'." `
                -Level INFO

            return
        }

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

    }
    catch {

        Write-LabLog `
            -Message "Graph connection failed: $($_.Exception.Message)" `
            -Level ERROR

        throw
    }
}