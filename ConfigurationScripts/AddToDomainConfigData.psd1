@{
    # Node related data
    AllNodes = @(
        @{ 
            Nodename = 'localhost' # Entry point
            NetworkInterfaceName = 'Ethernet'
            ComputerName = 'IIS-Server' # Name that will be given to the localhost
            PSDscAllowPlainTextPassword = $true
            PSDscAllowDomainUser = $true
            RetryCount = 20
            RetryIntervalSec = 30
        }
    );

    # Training scenario related data
    ScenarioData = @{
        DomainName = 'starkindustries.com'
        DnsServerAddress = '10.48.144.128' # IP address of active directory server
        DomainAdminPassword = 'bxNAHkhJ@#' 
        DomainServerName = 'WIN-KJGIJD5ELN1.starkindustries.com'
    }
}
