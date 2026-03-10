# Author: RJ Orr
# Purpose: Disable a user account and remove access.

# The user we want to offboard
$TargetUser = "jdoe" 

# 1. Disable the account in AD so they can't log in
Disable-ADAccount -Identity $TargetUser

# 2. Remove all group memberships
# We keep "Domain Users" because every account needs a primary group.
Get-ADPrincipalGroupMembership -Identity $TargetUser | Where-Object {$_.Name -ne "Domain Users"} | Remove-ADGroupMember -Members $TargetUser -Confirm:$false

# 3. Move the user to the 'Disabled' OU for organization
Move-ADObject -Identity (Get-ADUser $TargetUser).DistinguishedName -TargetPath "OU=Disabled,DC=lab,DC=local"

Write-Host "Offboarding complete for: $TargetUser"
