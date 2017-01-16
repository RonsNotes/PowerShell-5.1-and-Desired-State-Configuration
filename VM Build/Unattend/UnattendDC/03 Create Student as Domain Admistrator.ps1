New-ADUser -SamAccountName 'Student' -AccountPassword (ConvertTo-SecureString Passw0rd -AsPlainText -Force) -UserPrincipalName 'Student' -DisplayName 'Student' -Name 'Student' -Enabled $true
Add-ADGroupMember -Identity 'Enterprise admins' Student
Add-ADGroupMember -Identity 'Domain Admins' Student