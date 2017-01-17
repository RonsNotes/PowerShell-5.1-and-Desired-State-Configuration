Get-DscResource -Name Environment -Syntax

 configuration EnvironmentResource {
 Import-DscResource -ModuleName 'PSDesiredStateConfiguration'
 Node StudentServer2{
 Environment EnvironmentExample {
   Name = "MyEnvironmentExample"
   Value = "Example"

    }}}
EnvironmentResource -OutputPath 'C:\DSC Resources\MOF\Environment' -Verbose

Start-DscConfiguration -Path 'C:\DSC Resources\MOF\Environment\' -Wait -Verbose -Force