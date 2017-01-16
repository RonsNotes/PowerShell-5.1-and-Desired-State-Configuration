<#
 Uses functions to run tests. Uses helper function to Start-CountdownToExit to exit if failure. 
 9/8/2016
 Ron Davis
 BlueBuffaloPress
#>

Function Main
{
Restart-AsAdmin
Clear-Host
Invoke-TestForHyperVInstalled
Invoke-TestforSufficentMemory
Invoke-TestDriveSpaceRequired
Invoke-TestFor64Bit
Clear-Host
Create-vmSwitches
Create-DomainControler
Create-MemberServer
Create-MemberServer2
virtmgmt.msc
}

Function Restart-AsAdmin{
$isAdmin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")

If (!( $isAdmin )) {
	Write-Host "-- Restarting as Administrator" -ForegroundColor Cyan ; Sleep -Seconds 1
	Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs 
	exit
}
}

Function Create-DomainControler{
$VMName = "StudentDC" 
$SizeBytes = 20GB 
$ProcessorCnt = 1
$StartMemory = 1gb
$VHDXName = -join ($VMName,".vhdx")

New-VM -Name $VMName -NewVHDPath $VHDXName -NewVHDSizeBytes $SizeBytes -SwitchName `
"VMPrivateNetwork" -MemoryStartupBytes $StartMemory |Set-VMProcessor -Count $ProcessorCnt | Set-VMMemory -DynamicMemoryEnabled $false
}
Function Create-vmSwitches{
$ExistSwitchPrivate  = get-VMSwitch -SwitchType Private 
$ExistSwitchPrivate
If ($ExistSwitchPrivate) {
Write-Host "An existing Private switch exists named:" $ExistSwitchPrivate.Name -ForegroundColor Green; sleep -Seconds 1; 
}

ELSE { Write-Host "Creating new VMSwitch connected to Private" -ForegroundColor Yellow;
New-VMSwitch "VMPrivateNetwork" -SwitchType Private 
}


$ExistExternalSwitch =  Get-VMSwitch -SwitchType External

If ($ExistExternalSwitch) {
Write-Host "An existing external bound switch exists named:" $ExistExternalSwitch.Name -ForegroundColor Green; sleep -Seconds 1 ; 
}

ELSE { Write-Host "Creating new VMSwitch connected to External" -ForegroundColor Yellow;
New-VMSwitch "VMExternalNetwork" -NetAdapterName "Ethernet" -AllowManagementOS $true
}
}



Function Invoke-TestForHyperVInstalled{
$a = Get-WindowsOptionalFeature -Online -FeatureName *hyper-v*all 

IF ($a.state -ne 'enabled'){
Write-host "Restart will be rquired after the feature is installed"
Get-WindowsOptionalFeature -Online -FeatureName *hyper-v*all |
Enable-WindowsOptionalFeature -Online
}
Else{
Write-Host "Hyper-V installed and enabled" -ForegroundColor Green
}
}
Function Invoke-TestforSufficentMemory{
Param(
        $MemRequired = 12gb
    )

$InstalledRAM = Get-WmiObject -Class Win32_ComputerSystem
$InstalledRAM.TotalPhysicalMemory /1gb
IF ($InstalledRAM.TotalPhysicalMemory -gt $MemRequired) {Write-Host "Sufficent Memory for VM, OK" -ForegroundColor Green} 
ELSE {Start-CountdownToExit -Seconds 10 -Message "Insufficent memory" } 
}


Function Invoke-TestDriveSpaceRequired{


$Free_Space = Get-WmiObject -query "SELECT Freespace FROM win32_logicaldisk WHERE DeviceID = 'C:'" 
$Free_Space.FreeSpace

IF($Free_space.FreeSpace -gt 100gb) {Write-Host "C: Drive has suffiicent space, OK " -ForegroundColor Green} 
ELSE {Start-CountdownToExit -Seconds 10 -Message "Insufficent drive space for VM Do not proceed"}
}
Function Invoke-TestFor64Bit{
if ([System.IntPtr]::Size -eq 4) {Start-CountdownToExit -Seconds 10 -Message "32-bit system and will not work with VM Do not proceed"} 
else {Write-Host "64-bit OS and will work with VM, OK" -ForegroundColor Green} 
}

Function Start-CountdownToExit {  
 
#Default values of params used if functioned called without passing in values
    Param(
        [Int32]$Seconds = 5,
        [string]$Message = "Pausing for $seconds seconds..."
    )
    #$ErrMessage = "System Check Failed"
    #Start-Sleep -Seconds 3
    Write-Host "$Message preparing to exit. Please fix  condition " -ForegroundColor Red; Start-Sleep -Seconds 3
    ForEach ($Count in (1..$Seconds))
    {   Write-Progress -Id 1 -Activity $Message -Status "Waiting for $Seconds seconds, $($Seconds - $Count) left" -PercentComplete (($Count / $Seconds) * 100)
        Start-Sleep -Seconds 1
    }
    
 exit 
}

Function Create-MemberServer{
$VMName = "StudentServer" 
$SizeBytes = 30GB 
$ProcessorCnt = 1
$StartMemory = 2gb
$VHDXName = -join ($VMName,".vhdx")

New-VM -Name $VMName -NewVHDPath $VHDXName -NewVHDSizeBytes $SizeBytes -SwitchName `
"VMPrivateNetwork" -MemoryStartupBytes $StartMemory |Set-VMProcessor -Count $ProcessorCnt | Set-VMMemory -DynamicMemoryEnabled $false

}

Function Create-MemberServer2{
$VMName = "StudentServer2" 
$SizeBytes = 30GB 
$ProcessorCnt = 1
$StartMemory = 2gb
$VHDXName = -join ($VMName,".vhdx")

New-VM -Name $VMName -NewVHDPath $VHDXName -NewVHDSizeBytes $SizeBytes -SwitchName `
"VMPrivateNetwork" -MemoryStartupBytes $StartMemory |Set-VMProcessor -Count $ProcessorCnt | Set-VMMemory -DynamicMemoryEnabled $false

}


Main


