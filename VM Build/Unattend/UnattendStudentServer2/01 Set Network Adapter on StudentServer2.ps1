$IP = "10.0.0.3"
$MaskBits =  24 # This means subnet mask = 255.255.255.0
$Dns = "10.0.0.1"
$IPType = "IPv4"# Retrieve the network adapter that you want to configure

 # Configure the IP address and default gateway
New-NetIPAddress -InterfaceAlias 'Ethernet' -AddressFamily $IPType -IPAddress $IP -PrefixLength $MaskBits 
   
    `
# Configure the DNS client server IP addresses

Get-NetAdapter -Name 'ethernet' | Set-DnsClientServerAddress -ServerAddresses $DNS

Set-NetFirewallProfile -Profile Domain,Public,Private -Enabled False