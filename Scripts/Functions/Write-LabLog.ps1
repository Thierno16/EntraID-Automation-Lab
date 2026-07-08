function Write-LabLog {

    [CmdletBinding()]
    param(

        [Parameter(Mandatory)]
        [string]$Message,

        [ValidateSet("INFO","SUCCESS","WARNING","ERROR")]
        [string]$Level = "INFO",

        [string]$LogFilePath = "C:\EntraID-Lab\Logs\Day1_Joiner.log"

    )

    # Create timestamp
    $Timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"

    # Build log line
    $LogEntry = "[$Timestamp] [$Level] $Message"

    # Ensure log folder exists
    $Folder = Split-Path $LogFilePath

    if (!(Test-Path $Folder))
    {
        New-Item -ItemType Directory -Path $Folder -Force | Out-Null
    }

    # Console colours
    switch ($Level)
    {
        "INFO"    { $Color = "White" }
        "SUCCESS" { $Color = "Green" }
        "WARNING" { $Color = "Yellow" }
        "ERROR"   { $Color = "Red" }
    }

    # Write to console
    Write-Host $LogEntry -ForegroundColor $Color

    # Append to file
    Add-Content -Path $LogFilePath -Value $LogEntry

}