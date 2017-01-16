$isAdmin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")

If (!( $isAdmin )) {
	Write-Host "-- Restarting as Administrator" -ForegroundColor Cyan ; Sleep -Seconds 1
	Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs 
	exit
}

#Add external Switch to the StudentServer2
$MyExternalSwitch = Get-VMSwitch -SwitchType External

Add-VMNetworkAdapter -VMName StudentServer2 -Name Internet -SwitchName $MyExternalSwitch.Name
