Get-DscResource -Name Group -Syntax

Configuration GroupResource {
Import-DscResource -ModuleName 'PSDesiredStateConfiguration'
Node StudentServer2 {
Group GroupExample {
  GroupName = "ExampleGroup"
  #Members = "Nicole", "Rocky", "Mark"

   }}}
GroupResource -OutputPath 'C:\DSC Resources\MOF\Group' -Verbose

Start-DscConfiguration -Path 'C:\DSC Resources\MOF\Group\' -Wait -Verbose -Force