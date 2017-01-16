$isAdmin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")

If (!( $isAdmin )) {
	Write-Host "-- Restarting as Administrator" -ForegroundColor Cyan ; Sleep -Seconds 1
	Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs 
	exit
}

#Add external Switch to the StudentDC
$MyExternalSwitch = Get-VMSwitch -SwitchType External

Add-VMNetworkAdapter -VMName StudentDC -Name Internet -SwitchName $MyExternalSwitch.Name
