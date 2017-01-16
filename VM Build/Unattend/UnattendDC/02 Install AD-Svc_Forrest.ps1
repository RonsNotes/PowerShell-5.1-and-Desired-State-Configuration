$isAdmin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")
If (!( $isAdmin )) {
	Write-Host "-- Restarting as Administrator" -ForegroundColor Cyan ; Sleep -Seconds 1
	Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs 
	exit
}


Install-windowsfeature -name AD-Domain-Services -IncludeManagementTools
$domain_Name = "bluebuffalo.training.local"
$secure_string_pwd = ConvertTo-SecureString "Passw0rd" -asplaintext -Force
Install-ADDSForest -DomainName $domain_Name -SkipPreChecks -InstallDns:$true -DomainNetbiosName BlueBuffalo -SafeModeAdministratorPassword $secure_string_pwd -Force
Set-NetFirewallProfile -Profile domain,Public,Private -Enabled False 

