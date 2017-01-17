Configuration FilteredDSC2 {
Import-DscResource  -ModuleName 'PSDesiredStateConfiguration'

    node $AllNodes.Where({$_.Role -Like 'Experiment'}).NodeName {
    
         Log SampleMessage
        {
            Message = "Sample Message for Experiment Server" 

        }}
        node $AllNodes.Where({$_.Role -Like 'FileServer'}).NodeName {

      Log SampleMessage
      {
            Message = "Sample Message for File Server" 
      }
        }}

    FilteredDSC2 -ConfigurationData 'C:\MyScripts\ConfigData.psd1'`
    -OutputPath 'C:\MyScripts\MOF' -Verbose