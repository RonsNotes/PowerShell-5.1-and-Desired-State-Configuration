# DSC configuration for Pull Server
# Prerequisite: Certificate "CN=PSDSCPullServerCert" in "CERT:\LocalMachine\MY\" store for SSL
# Prerequisite: $RegistrationKey value generated using ([guid]::NewGuid()).Guid
# Note: A Certificate may be generated using MakeCert.exe: http://msdn.microsoft.com/en-us/library/windows/desktop/aa386968%28v=vs.85%29.aspx

configuration Instructor_Commented_Sample_xDscWebService 
{ 
    param  
    ( 
            [string[]]$NodeName = 'localhost', # Can change by passing in parameter when compiling

            [Parameter(HelpMessage='Use AllowUnencryptedTraffic for setting up a non SSL based endpoint (Recommended only for test purpose)')]
            [ValidateNotNullOrEmpty()] 
            [string] $certificateThumbPrint, # Can change by passing in parameter when compiling and use the attribut "AllowUnencrytedTraffic" to allow HTTP 

            [Parameter(HelpMessage='This should be a string with enough entropy (randomness) to protect the registration of clients to the pull server.  We will use new GUID by default.')]
            [ValidateNotNullOrEmpty()]

            [string] $RegistrationKey = ([guid]::NewGuid()).Guid #New v5 feature to create for us the registration GUID
     ) 


     Import-DSCResource -ModuleName xPSDesiredStateConfiguration #Imports both modules to allow name flesibilty IE use or do not use the x

     Import-DSCResource -ModuleName PSDesiredStateConfiguration 

     Node $NodeName 
     { 
         WindowsFeature DSCServiceFeature #Required feature for DSC. SHow screen shot in course of the Server managr wizard showing this feature installed
         { 
             Ensure = "Present" 
             Name   = "DSC-Service"             
         } 


         xDscWebService PSDSCPullServer #Populates the class attributres to create the web service 
         { 
             Ensure                  = "Present" 

             EndpointName            = "PSDSCPullServer_Unencrypted" #Modified and point out that this does not change the name of the web service 
            
             Port                    = 8081 #Modified for Demo 
            
             PhysicalPath            = "$env:SystemDrive\inetpub\PSDSCPullServer" #Default location and name 
          
             CertificateThumbPrint   = $certificateThumbPrint         
          
             ModulePath              = "$env:PROGRAMFILES\WindowsPowerShell\DscService\Modules" #Default location and name 
          
             ConfigurationPath       = "$env:PROGRAMFILES\WindowsPowerShell\DscService\Configuration"       #Default location and name       
          
             State                   = "Started" 
          
             DependsOn               = "[WindowsFeature]DSCServiceFeature"     #This will prevent the web service from being created unless the DSC service is present and started
             
             AcceptselfSignedCertificates = $true

            
                                 
         } 

        File RegistrationKeyFile #Created for us by [string] $RegistrationKey = ([guid]::NewGuid()) 
        {
            Ensure          ='Present'
            Type            = 'File'
            DestinationPath = "$env:ProgramFiles\WindowsPowerShell\DscService\RegistrationKeys.txt"
            Contents        = $RegistrationKey
        }
    }
}

#Instructor_Commented_Sample_xDscWebService  -certificateThumbPrint $($DSCCert).Thumbprint -output C:\Demo 

Instructor_Commented_Sample_xDscWebService  -certificateThumbPrint "AllowUnencryptedTraffic" -output C:\Demo\NoCert\ #AllowUnencrytedTraffic creates a HTTP site 

#Start-DscConfiguration -Path C:\Demo -Wait  -Verbose -Force 

Start-DscConfiguration -Path C:\Demo\NoCert -Wait  -Verbose -Force 


