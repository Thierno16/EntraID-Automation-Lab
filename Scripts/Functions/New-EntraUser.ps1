function New-EntraUser {

    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [pscustomobject]$User
    )

    Write-LabLog -Message "Processing $($User.DisplayName)..."

    try {

        # Check whether the user already exists
        $ExistingUser = Get-MgUser `
            -Filter "userPrincipalName eq '$($User.UserPrincipalName)'" `
            -ErrorAction SilentlyContinue

        if ($ExistingUser) {

            Write-LabLog `
                -Message "$($User.UserPrincipalName) already exists. Skipping." `
                -Level WARNING

            return
        }

        # Build password profile
        $PasswordProfile = @{
            Password = $DefaultPassword
            ForceChangePasswordNextSignIn = $true
        }

        # Create the user
        New-MgUser `
            -AccountEnabled `
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
            -Message "$($User.DisplayName) created successfully." `
            -Level SUCCESS

    }
    catch {

        Write-LabLog `
            -Message "Failed to create $($User.DisplayName): $($_.Exception.Message)" `
            -Level ERROR

    }

}