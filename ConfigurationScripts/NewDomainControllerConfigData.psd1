@{
    # Node related data
    AllNodes = @(
        @{ 
            Nodename = 'localhost' # Entry point
            Role = 'Primary DC'
            NetworkInterfaceName = 'Ethernet'
            PSDscAllowPlainTextPassword = $true
            RetryCount = 20
            RetryIntervalSec = 30
        }
    );

    # Training scenario related data
    ScenarioData = @{
        DomainName = 'starkindustries.com'
        DomainAdminPassword = 'bxNAHkhJ@#' # Same password will be used for Safe mode
    }
}