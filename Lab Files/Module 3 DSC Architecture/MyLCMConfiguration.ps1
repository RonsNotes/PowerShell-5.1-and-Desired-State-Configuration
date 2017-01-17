Get-DscLocalConfigurationManager
cd C:\MyScripts
#LCM Sample Configuration begins below
[DscLocalConfigurationManager()]
configuration MyLCMConfiguration
{
    Node localhost
    {
        Settings
        {
            RefreshFrequencyMins = 40
        }
    }

} #End of LCM sample configuration

MyLCMConfiguration  # This call will cause the PS1 
                    # file to run and the engine will generate a MOF