Configuration FilteredDSC {
Import-DscResource  -ModuleName 'PSdesiredStateConfiguration'

    node $AllNodes.Where({$_.Role -Like 'Experiment'}).NodeName {
  
        Log SampleMessage
        {
           Message = "Sample Message for Experiment Server"

        }}}
    FilteredDSC -ConfigurationData 'C:\MyScripts\ConfigData.psd1'`
    -OutputPath 'C:\MyScripts\MOF' -Verbose