#Get-DscResource -Name file -Syntax
configuration ShowFileResource2 {
 Import-DscResource -ModuleName 'PSDesiredStateConfiguration'

 node StudentServer2 {
    File FileExample {
    DestinationPath = "C:\RonsNotes\PowerShellDSC\Labs" #Required
    Attributes = 'Readonly' #Optional
    Type = 'Directory'
    Ensure = 'Present'

    }}
 node StudentServer2 {
   File FileExample2 {
   DestinationPath = "C:\RonsNotes\PowerShellDSC\Labs\TestofFile.txt"
   Contents = ""

}}}

ShowFileResource2 -OutputPath 'C:\DSC Resources\MOF\File' -Verbose

#Start-DscConfiguration -Path 'C:\DSC Resources\MOF\File\' -Wait -Verbose -Force