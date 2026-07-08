function Test-EntraUserExists {

    [CmdletBinding()]
    param(

        [Parameter(Mandatory)]
        [string]$UserPrincipalName

    )

    try
    {
        $User = Get-MgUser `
            -Filter "userPrincipalName eq '$UserPrincipalName'" `
            -ErrorAction Stop

        return ($null -ne $User)
    }

    catch
    {
        throw $_
    }

}