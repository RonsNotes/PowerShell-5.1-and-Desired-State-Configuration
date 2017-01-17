Get-DscResource -Name Log -Syntax

 Configuration LogResource {
 Import-DscResource -ModuleName 'PSDesiredStateConfiguration'
 Node StudentServer2{
 Log LogExample {
   Message = "DSC will revolutionize server setup!"

    }}}
LogResource -OutputPath 'C:\DSC Resources\MOF\Log' -Verbose

Start-DscConfiguration -Path 'C:\DSC Resources\MOF\Log\' -Wait -Verbose -Force