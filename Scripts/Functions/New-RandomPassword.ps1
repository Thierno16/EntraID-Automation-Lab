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