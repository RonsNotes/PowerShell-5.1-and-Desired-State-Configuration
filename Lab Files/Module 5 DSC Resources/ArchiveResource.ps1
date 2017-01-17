Get-DscResource -Name Archive -Syntax

 configuration ShowArchive {
 Import-DscResource -ModuleName 'PSDesiredStateConfiguration'
 Node StudentServer2{
 Archive ArchiveExample {
   # Ensure = "Present"  # You can also set Ensure to "Absent"
    Path = "C:\Users\Student\Desktop\Archive Resource\TestFiles.zip"
    Destination = "C:\DSC Resources\Documents\ExtractionPath"
    }}}
ShowArchive -OutputPath 'C:\DSC Resources\MOF\Archive' -Verbose

Start-DscConfiguration -Path 'C:\DSC Resources\MOF\Archive\' -Wait -Verbose -Force