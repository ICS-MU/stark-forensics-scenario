Simulated MS Windows corporate environment
------------------------------------------

This tools are designed to build simulated MS Windows corporate environment suitable for forensics training. Please see [**this thesis**](https://is.muni.cz/auth/th/qs8gc/Janovskij-Thesis.pdf) by Vadim Janovskij for complete info and tutorials.

Steps for building basic environment
------------------------------------

This is a step-by-step guide, how to build the core environment including DC-Server, IIS-Server, Exchange-Server and SQL-Server. All machines are initialized in Metacentrum Cloud environment in the same network.

1. Create a linux virtual machine and configure Apache shared storage for large files here. Copy here all the files from DeployingEnvironment folder (as this is used as central repository, from where scripts are manually reachable from all VMs) and files for SQL and Exchange server (*see below). This operation can be automated by `apache-file-share-install.sh` script in ExecutionScripts folder.
2. Create virtual machine with Windows Server 2016 system representing the DC Server. (for example in Metacentrum image id 5149). 
3. Generalize a Windows installation (this step needs to be done for all virtual machines with Windows Server). Run application `sysprep.exe` in C:\Windows\System32\Sysprep and check the Generalize box. 
4. Run script `InstallPrerequisites-DC.ps1` in ExecutionScripts/NewDomainController folder. This step needs to be done with open internet connection to the machine. After this step, close the internet connection.
5. Run script `Start-NewDomainController.ps1` in ExecutionScripts/NewDomainController. You can also specify configuration data in `NewDomainControllerConfigData.psd1` in ConfigurationScripts folder. This step promote the VM into DC-Server. Path to ConfigurationScripts is by default in Downloads folder (if downloaded from apache server), if needed, change the path in `Start-NewDomainController.ps1` (applies to all scripts beggining with "Start-" on other machines too)
6. Create 3 new virtual machines with Windows Server and generalize them (step 3.). Run in each of them the `InstallPrerequisites-AddToDomain.ps1` script from  ExecutionScripts/AddToDomain folder with open internet connection, then close it. Add the VMs into Active Directory Domain by running `Start-AddToDomain.ps1` script with proper `AddToDomainConfigData.psd1` configuration file for each VM (e.g. setting DnsServerAddress of active directory server and changing computer name to IIS-Server, SQL-Server or Exchange-Server). If the first part of the script doesn't work (setting the DNS), set DNS in the VM manually to the address of DC-Server.
7. Install prerequisites on SQL-Server and Exchange-Server with `InstallPrerequisites-SQL.ps1` and `InstallPrerequisites-Exchange.ps1`. Make sure internet connection is closed after this step.
8. From the DC-Server, run `Start-NewIIS.ps1`, `Start-NewExchangeServer.ps1` and `Start-NewSQLServer.ps1` with its proper configuration data.

\* Files needed for Exchange and SQL server configuration. 
- [Unified Communications Managed API](https://www.microsoft.com/en-us/download/details.aspx?id=34992)
- [Microsoft Exchange Server 2016](https://www.microsoft.com/en-us/download/details.aspx?id=49161)
- [SQL Server Management Studio](https://docs.microsoft.com/en-us/sql/ssms/download-sql-server-management-studio-ssms?view=sql-server-2017)
- [SQL Server 2016 ISO](https://uploadfiles.io/90yhe)
