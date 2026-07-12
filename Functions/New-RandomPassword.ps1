<#
.SYNOPSIS
Creates a secure random password.

.DESCRIPTION
Generates a random password that meets enterprise complexity requirements.

.PARAMETER Length
Length of the generated password.

.EXAMPLE
New-RandomPassword

.EXAMPLE
New-RandomPassword -Length 20

.NOTES
Author: Thierno Bah
Version: 1.0
#>

function New-RandomPassword {

    [CmdletBinding()]
    param(
        [int]$Length = 14
    )

    # Character sets
    $Upper   = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    $Lower   = "abcdefghijklmnopqrstuvwxyz"
    $Numbers = "0123456789"
    $Special = "!@#$%^&*()-_=+?"

    # Ensure one character from each category
    $Password = @()

    $Password += $Upper[(Get-Random -Maximum $Upper.Length)]
    $Password += $Lower[(Get-Random -Maximum $Lower.Length)]
    $Password += $Numbers[(Get-Random -Maximum $Numbers.Length)]
    $Password += $Special[(Get-Random -Maximum $Special.Length)]

    # Combine all character sets
    $AllCharacters = $Upper + $Lower + $Numbers + $Special

    # Fill remaining length
    while ($Password.Count -lt $Length)
    {
        $Password += $AllCharacters[(Get-Random -Maximum $AllCharacters.Length)]
    }

    # Shuffle the password
    $Password = $Password | Get-Random -Count $Password.Count

    return (-join $Password)
}