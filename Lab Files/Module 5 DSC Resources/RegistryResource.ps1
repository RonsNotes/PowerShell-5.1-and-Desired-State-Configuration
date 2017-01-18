Get-DscResource -Name Registry -Syntax

 Configuration RegistryResource {
 Import-DscResource -ModuleName 'PSDesiredStateConfiguration'
 Node StudentServer2{
 Registry RegistryExample {

   Key = "HKEY_Local_Machine\SOFTWARE\RonsNotes"
   ValueName = "JustADemo"
   ValueData = "0x01"
   ValueType = "Dword"
   Hex = $true
}

    }}


RegistryResource -OutputPath 'C:\DSC Resources\MOF\Registry' -Verbose

Start-DscConfiguration -Path 'C:\DSC Resources\MOF\Registry\' -Wait -Verbose -Force