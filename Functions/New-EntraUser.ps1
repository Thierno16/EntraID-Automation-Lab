<#
.SYNOPSIS
Creates a new Microsoft Entra ID user.

.DESCRIPTION
Creates a Microsoft Entra ID user using Microsoft Graph.

.PARAMETER User
User object imported from the onboarding CSV.

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
        # Generate temporary password
        #-------------------------------------------------

        $Password = "Temp!" + (Get-Random -Minimum 100000 -Maximum 999999) + "!"

        Write-LabLog `
            -Message "Creating user $($User.DisplayName)" `
            -Level INFO

        #-------------------------------------------------
        # Build request body
        #-------------------------------------------------

        $Body = @{
            accountEnabled = $true
            displayName    = $User.DisplayName
            givenName      = $User.FirstName
            surname        = $User.LastName
            mailNickname   = $User.MailNickname
            userPrincipalName = $User.UserPrincipalName
            department     = $User.Department
            jobTitle       = $User.JobTitle
            officeLocation = $User.OfficeLocation
            usageLocation  = $User.UsageLocation
            employeeId     = $User.EmployeeId

            passwordProfile = @{
                password = $Password
                forceChangePasswordNextSignIn = $true
            }
        }

        #-------------------------------------------------
        # Create user
        #-------------------------------------------------

        $NewUser = New-MgUser -BodyParameter $Body

        Write-LabLog `
            -Message "Created user $($User.UserPrincipalName)" `
            -Level SUCCESS

        return @{
            User     = $NewUser
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