@{
    # Node related data
    AllNodes = @(
        @{ 
            Nodename = 'SQL-Server' # Entry point
            Role = 'SQL Server'
            PSDscAllowPlainTextPassword = $true
            SSMS_EXE = "http://10.48.144.62/sql-server/SSMS-Setup-ENU.exe"
	    SSMS_EXE_PRODUCTID = "9BBE717B-128F-4470-9032-F373273DD237"
            SQL_ISO = "http://10.48.144.62/sql-server/SQLServer2016SP1-FullSlipstream-x64-ENU.iso"
            RetryCount = 20
            RetryIntervalSec = 30
        }
    );

    # Training scenario related data
    ScenarioData = @{
        
    }
}