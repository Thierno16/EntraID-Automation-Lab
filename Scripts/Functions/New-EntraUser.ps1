<#
.SYNOPSIS
Creates a new Microsoft Entra ID user.

.DESCRIPTION
Creates a Microsoft Entra ID user using Microsoft Graph.

.PARAMETER User
User object imported from the onboarding CSV.

.OUTPUTS
Microsoft.Graph.PowerShell.Models.IMicrosoftGraphUser

.EXAMPLE
New-EntraUser -User $User
#>

function New-EntraUser {

    [CmdletBinding()]
    param(

        [Parameter(Mandatory)]
        [PSCustomObject]$User

    )

    try {

        #-------------------------------------------------
        # Generate a temporary password
        #-------------------------------------------------

        $Password = "Temp!" + (Get-Random -Minimum 100000 -Maximum 999999) + "!"

        $PasswordProfile = @{
            Password = $Password
            ForceChangePasswordNextSignIn = $true
            ForceChangePasswordNextSignInWithMfa = $false
        }

        #-------------------------------------------------
        # Create the Entra ID user
        #-------------------------------------------------
 
        Write-LabLog `
            -Message "Creating user $($User.DisplayName)" `
            -Level INFO

        $NewUser = New-MgUser `
            -AccountEnabled $true `
            -DisplayName $User.DisplayName `
            -GivenName $User.FirstName `
            -Surname $User.LastName `
            -MailNickname $User.MailNickname `
            -UserPrincipalName $User.UserPrincipalName `
            -Department $User.Department `
            -JobTitle $User.JobTitle `
            -OfficeLocation $User.OfficeLocation `
            -UsageLocation $User.UsageLocation `
            -EmployeeId $User.EmployeeId `
            -PasswordProfile $PasswordProfile

        Write-LabLog `
            -Message "Created user $($User.UserPrincipalName)" `
            -Level SUCCESS

        return @{
            User = $NewUser
            Password = $Password
        }

    }
    catch {

        Write-LabLog `
    -Message "Failed to create user $($User.UserPrincipalName). Error: $($_.Exception.Message)" `
    -Level ERROR
        throw

    }

}