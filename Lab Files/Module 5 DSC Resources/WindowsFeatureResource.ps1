Get-DscResource -Name WindowsFeature -Syntax

Configuration WindowsFeatureResource {
Import-DscResource -ModuleName 'PSDesiredStateConfiguration'
Node StudentServer2{
WindowsFeature WindowsFeatureResourceExample
{

 Name = "AD-Domain-Services"
 IncludeAllSubFeature = $true
 Ensure = "Present"

}}}

WindowsFeatureResource -OutputPath 'C:\DSC Resources\MOF\WindowsFeature\'

Start-DscConfiguration -Path 'C:\DSC Resources\MOF\WindowsFeature\' -Wait -Verbose -Force