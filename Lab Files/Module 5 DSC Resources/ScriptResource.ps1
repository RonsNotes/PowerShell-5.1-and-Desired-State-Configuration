Get-DscResource -Name Script -Syntax

New-Item -ItemType Directory -Path "C:\MyTempFolder\"
Configuration ScriptResource {
Import-DscResource -ModuleName 'PSDesiredStateConfiguration'
Node StudentServer2{
Script ScriptResourceExample

{
    SetScript = {
        $sw = New-Object System.IO.StreamWriter("C:\MyTempFolder\TestFile.txt")
        $sw.WriteLine("DSC Rules!")
        $sw.Close()
    }
    TestScript = { Test-Path "C:\MyTempFolder\TestFile.txt"}
    GetScript = { @{ Result = (Get-Content C:\MyTempFolder\TestFile.txt) } }
}}}

ScriptResource -OutputPath 'C:\DSC Resources\MOF\Script\'

Start-DscConfiguration -Path 'C:\DSC Resources\MOF\Script\' -Wait -Verbose -Force