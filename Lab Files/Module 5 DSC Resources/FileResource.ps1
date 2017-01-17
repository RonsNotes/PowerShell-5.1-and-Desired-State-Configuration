Get-DscResource -Name file -Syntax
configuration ShowFileResource {
 Import-DscResource -ModuleName 'PSDesiredStateConfiguration'

 node StudentServer2 {
    File FileExample {
    DestinationPath = "C:\BlueBuffaloPress\PowerShellDSC\Labs" #Required
    Attributes = 'Readonly' #Optional
    Type = 'Directory'
    Ensure = 'Present'

    }}
}
ShowFileResource -OutputPath 'C:\DSC Resources\MOF\File' -Verbose

#Start-DscConfiguration -Path 'C:\DSC Resources\MOF\File\' -Wait -Verbose -Force