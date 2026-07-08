. "$PSScriptRoot\Functions\Write-LabLog.ps1"

Write-LabLog -Message "Starting onboarding"

Write-LabLog -Message "Creating John Smith" -Level SUCCESS

Write-LabLog -Message "User already exists" -Level WARNING

Write-LabLog -Message "License assignment failed" -Level ERROR