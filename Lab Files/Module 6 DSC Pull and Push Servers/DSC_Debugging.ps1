Clear-Host
Enable-DscDebug -BreakAll
$MyLcm = Get-DscLocalConfigurationManager
$MyLcm.DebugMode

#Test Configuration 
Configuration PSEngine2
    {
    Import-DscResource -ModuleName 'PsDesiredStateConfiguration'
    Node localhost
        {
        WindowsFeature PSv2
            {
            Name = 'PowerShell-v2'
            Ensure = 'Present'
            }}}
PSEngine2 -outputpath 'C:\Demo\Debug'
Start-DscConfiguration -Path C:\Demo\Debug -Wait  -Verbose -Force # Using -Force because LCM is configured for Pull