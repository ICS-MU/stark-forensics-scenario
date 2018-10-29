Configuration NewDomainController 
{
    Import-DscResource –ModuleName 'PSDesiredStateConfiguration'
    Import-DscResource -ModuleName 'xActiveDirectory'
    Import-DscResource -ModuleName 'xNetworking'

    Node $AllNodes.Where{$_.Role -contains"Primary DC"}.Nodename
    {
        $safemodeAdministratorCred = (New-Object System.Management.Automation.PSCredential ('Administrator', (ConvertTo-SecureString $ConfigurationData.ScenarioData.DomainAdminPassword -AsPlainText -Force)))
        $domainCred = (New-Object System.Management.Automation.PSCredential ('Administrator', (ConvertTo-SecureString $ConfigurationData.ScenarioData.DomainAdminPassword -AsPlainText -Force)))

        LocalConfigurationManager            
        {            
            ActionAfterReboot = 'ContinueConfiguration'            
            ConfigurationMode = 'ApplyOnly'            
            RebootNodeIfNeeded = $true            
        }

        WindowsFeature DNS
        {
            Ensure = "Present"
            Name = "DNS"
        }

        xDnsServerAddress DnsServerAddress
        {
            Address        = '127.0.0.1'
            InterfaceAlias = $Node.NetworkInterfaceName
            AddressFamily  = 'IPv4'
            DependsOn = '[WindowsFeature]DNS'
        }
         
        WindowsFeature ADDSInstall
        {
            Ensure = 'Present'
            Name = 'AD-Domain-Services'
        }
        WindowsFeature RSATTools
        {
            DependsOn= '[WindowsFeature]ADDSInstall'
            Ensure = 'Present'
            Name = 'RSAT-AD-Tools'
            IncludeAllSubFeature = $true
        }

        xADDomain FirstDS
        {
            DomainName = $ConfigurationData.ScenarioData.DomainName
            DomainAdministratorCredential = $domainCred
            SafemodeAdministratorPassword = $safemodeAdministratorCred
            DependsOn = '[WindowsFeature]RSATTools'
        }

        xWaitForADDomain DscForestWait
        {
            DomainName = $ConfigurationData.ScenarioData.DomainName
            DomainUserCredential = $domainCred
            RetryCount = $Node.RetryCount
            RetryIntervalSec = $Node.RetryIntervalSec
            DependsOn = '[xADDomain]FirstDS'
        }
    }
}