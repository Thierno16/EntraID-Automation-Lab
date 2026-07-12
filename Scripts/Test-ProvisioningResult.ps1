. "$PSScriptRoot\Functions\Add-ProvisioningResult.ps1"

$Result = Add-ProvisioningResult `
    -DisplayName "John Smith" `
    -UserPrincipalName "john.smith@SoulbyLTD.onmicrosoft.com" `
    -Status Created `
    -Password "Temp!123456!" `
    -Message "User created successfully."

$Result