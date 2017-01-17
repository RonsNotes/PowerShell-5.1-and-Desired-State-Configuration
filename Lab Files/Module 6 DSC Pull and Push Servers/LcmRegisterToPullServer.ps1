# Setting up a Pull Client 

# Attribute decoration which makes this a "special" configuration 
[DSCLocalConfigurationManager()]      
configuration LocalHostLCMConfig
{
    Node StudentServer2
    {
        Settings
        {
            RefreshMode          = 'Pull'
            RefreshFrequencyMins = 30 
            RebootNodeIfNeeded   = $true
        }

        ConfigurationRepositoryWeb StudentServer2    # Use the name of your server                       
        {
            ServerURL          = 'http://StudentServer2:8086/PSDSCPullServer.svc' # We are using HTTP as we are not using certificates 
            RegistrationKey    = 'b6481af0-21c1-453e-bf1a-aa40bb20075d'      #replace with yours
            ConfigurationNames = @('StudentServer2')     #match to the name of the NodeName you will use in your client MOF                    
            AllowUnsecureConnection = $true
        }   

        ReportServerWeb StudentServer2    # Use the name of your server                                  
        {
            ServerURL       = 'http://StudentServer2:8086/PSDSCPullServer.svc'
            RegistrationKey = 'b6481af0-21c1-453e-bf1a-aa40bb20075d'         #replace with yours
            AllowUnsecureConnection = $true
        }
    }
}

LocalHostLCMConfig  -OutputPath c:\Configs\TargetNodes  

Set-DscLocalConfigurationManager -Path C:\Configs\TargetNodes\ -Verbose -Force
Get-DscLocalConfigurationManager