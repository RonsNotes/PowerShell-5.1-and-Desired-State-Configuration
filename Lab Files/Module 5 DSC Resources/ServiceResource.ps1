Get-DscResource -Name Service -Syntax

Configuration ServiceResource {
Import-DscResource -ModuleName 'PSDesiredStateConfiguration'
Node StudentServer2{
Service ServiceResourceExample
{
    Name = "AudioSrv"
    State = "Running"

}}}

ServiceResource -OutputPath 'C:\DSC Resources\MOF\Service\'

Start-DscConfiguration -Path 'C:\DSC Resources\MOF\Service\' -Wait -Verbose -Force