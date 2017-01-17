Configuration FilteredDSC3 {
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
          }
          node $AllNodes.Where({$_.AltRole -Like 'Party'}).NodeName {

      Log SampleMessage
          {
            Message = "It all died with the Armadillo" 

          }
 }}

    FilteredDSC3 -ConfigurationData 'C:\MyScripts\ConfigData2.psd1'`
     -OutputPath 'C:\MyScripts\MOF' -verbose