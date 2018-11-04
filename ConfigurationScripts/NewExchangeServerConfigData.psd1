@{
    # Node related data
    AllNodes = @(
        @{ 
            Nodename = 'EXCHANGE-SERVER'
            Role = 'Exchange-Server'
            PSDscAllowPlainTextPassword = $true
	    UCMA_EXE = "http://10.48.144.62/exchange/UcmaRuntimeSetup.exe"
            UCMA_EXE_PRODUCTID = "ED98ABF5-B6BF-47ED-92AB-1CDCAB964447"
            EXCHANGE_EXE = "http://10.48.144.62/exchange/Exchange2016-x64.exe"
            RetryCount = 20
            RetryIntervalSec = 30
        }
    );

    # Training scenario related data
    ScenarioData = @{
        DomainName = 'starkindustries.com'
        DomainAdminPassword = 'bxNAHkhJ@#'
    }
}