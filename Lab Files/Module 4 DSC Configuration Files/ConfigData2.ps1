@{
    AllNodes = @(
        @{
            NodeName = 'DallasSRV'
            Role = 'Experiment'
          
        },
        @{
            NodeName = 'ChicagoSRV'
            Role = 'FileServer'
            
        }
        @{
            NodeName = 'AustinSRV'
            AltRole = 'Party'
        }
    )
}