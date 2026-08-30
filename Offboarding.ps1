param(
    [Parameter(Mandatory=$true)]
    [string]$TargetUser
)

try {
    # 1. Disables the account in AD
    Disable-ADAccount -Identity $TargetUser -ErrorAction Stop
    Write-Host "Disabled account: $TargetUser" -ForegroundColor Yellow

    # 2. Removes all group memberships (preserving Domain Users)
    Get-ADPrincipalGroupMembership -Identity $TargetUser | 
        Where-Object {$_.Name -ne "Domain Users"} | 
        Remove-ADGroupMember -Members $TargetUser -Confirm:$false -ErrorAction Stop

    # 3. Moves the user to the Disabled OU
    $UserObj = Get-ADUser $TargetUser -ErrorAction Stop
    Move-ADObject -Identity $UserObj.DistinguishedName -TargetPath "OU=Disabled,DC=lab,DC=local" -ErrorAction Stop

    Write-Host "Offboarding complete for: $TargetUser" -ForegroundColor Green
}
catch {
    Write-Error "Offboarding failed for $TargetUser : $_"
}
