# Author: RJ Orr
# Lab: Active Directory User Onboarding

# Creating a secure password for the new accounts
$Password = ConvertTo-SecureString "Welcome2026!" -AsPlainText -Force

# Importing the list of new hires
$NewUsers = Import-Csv "C:\Lab\new_hires.csv"

foreach ($User in $NewUsers) {
    
    # The CSV didn't have usernames, so I'm making them from First Initial + Last Name.
    # Example: John Doe becomes jdoe
    $UserName = ($User.FirstName.Substring(0,1) + $User.LastName).ToLower()
    
# Create the user with basic info and security settings
New-ADUser -Name "$($User.FirstName) $($User.LastName)" -SamAccountName $UserName -UserPrincipalName "$UserName@yourdomain.com" `
    -Department $User.Department -Title $User.JobTitle `
    -AccountPassword $Password -ChangePasswordAtLogon $true -Enabled $true -Path "OU=Users,DC=lab,DC=local"
               
    Write-Host "Created account for $UserName"
}
