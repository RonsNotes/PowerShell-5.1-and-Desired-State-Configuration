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
            Message = "Another Sample Message" 
        }
        File SampleFile
        {
        Ensure = "Present"
        Type = "Directory"
        DestinationPath = "C:\MyDemoDirectory\"
           
    }
    }
    }

SampleLog -ConfigurationData $configData -outputpath C:\Holding\Configurations\ 
New-DscChecksum -Path C:\Holding\Configurations\ -Force
# You must move the files to the Configuration folder before executing the next line.
Update-DscConfiguration -Verbose -Wait