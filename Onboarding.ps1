$DomainName = "lab.local"
$Password = ConvertTo-SecureString "Welcome2026!" -AsPlainText -Force 
$NewUsers = Import-Csv "C:\Lab\new_hires.csv" 

# Loop through CSV rows and provision new AD accounts
foreach ($User in $NewUsers) {
    $UserName = ($User.FirstName.Substring(0,1) + $User.LastName).ToLower()
    try {
        New-ADUser -Name "$($User.FirstName) $($User.LastName)" -SamAccountName $UserName -UserPrincipalName "$UserName@$DomainName" -Department $User.Department -Title $User.JobTitle -AccountPassword $Password -ChangePasswordAtLogon $true -Enabled $true -Path "OU=Users,OU=Corporate,DC=lab,DC=local" -ErrorAction Stop

        Write-Host "Created account for $UserName" -ForegroundColor Green
    }
    catch {
        Write-Warning "Failed to create user $UserName : $_"
    }
}
