Configuration NewSQLServer
{
    Import-DscResource -ModuleName xSQLServer
    Import-DscResource -ModuleName StorageDsc
    Import-DscResource -ModuleName xPSDesiredStateConfiguration

   
    Node $AllNodes.Where{$_.Role -contains"SQL Server"}.Nodename
    {
        
         File SQLInstallationDirectory
        {
            Ensure          = 'Present'
            Type            = 'Directory'
            Recurse         = $false
            SourcePath = 'C:\SQLInstallationDirectory'
            DestinationPath = 'C:\SQLInstallationDirectory'
        }

        # Download ISO from url
        xRemoteFile DownloadISO
        {
            DestinationPath = "C:\SQLInstallationDirectory\SQLServer.iso"
            Uri = $AllNodes.SQL_ISO
            DependsOn = '[File]SQLInstallationDirectory'
        }

        # Download SSMS from url
        xRemoteFile DownloadSSMS
        {
            DestinationPath = "C:\SQLInstallationDirectory\SSMS-Setup-ENU.exe"
            Uri = $AllNodes.SSMS_EXE
        }
 

        MountImage ISO
        {
            ImagePath   = "C:\SQLInstallationDirectory\SQLServer.iso"
            DriveLetter = 'K'
        }

        WaitForVolume WaitForISO
        {
            DriveLetter      = 'K'
            RetryIntervalSec = 5
            RetryCount       = 10
        }

        WindowsFeature NetFramework35Core
        {
             Name = "NET-Framework-Core"
             Ensure = "Present"
        }
  
         WindowsFeature NetFramework45Core
        {
             Name = "NET-Framework-45-Core"
             Ensure = "Present"
        }

        xSQLServerSetup 'InstallDefaultInstance'
        {
              InstanceName = 'MSSQLSERVER'
              Features = 'SQLENGINE,FULLTEXT,RS,AS,IS'
              SourcePath = 'K:\'
              SQLSysAdminAccounts = 'Administrator'
              DependsOn = '[WindowsFeature]NetFramework45Core'
        }

        Package SSMS
        {
	        Ensure = "Present"
	        Name = "SSMS"
	        Path = "C:\SQLInstallationDirectory\SSMS-Setup-ENU.exe"
	        ProductId = $AllNodes.SSMS_EXE_PRODUCTID
        }
        
    }
}

