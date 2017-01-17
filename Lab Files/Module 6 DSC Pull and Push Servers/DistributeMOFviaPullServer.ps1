$configData = @{
    AllNodes = @(
        @{
            NodeName = 'StudentServer2'                      
        }
    )    
}
Configuration SampleLog

{
Import-DscResource -ModuleName PSDesiredStateConfiguration
    node $AllNodes.Nodename
    {
        Log SampleMessage
        {
            Message = "Sample Message" 
        }
        
    }
}

SampleLog -ConfigurationData $configData -outputpath C:\Holding\Configurations\ 
New-DscChecksum -Path C:\Holding\Configurations\
# You must move the files to the Configuration folder before executing the next line.
Update-DscConfiguration -Verbose -Wait