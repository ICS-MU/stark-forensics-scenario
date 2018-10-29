Configuration AddToDomain
{

    Import-DscResource -Module ComputerManagementDsc
    Import-DscResource -ModuleName xNetworking
    
    Node $AllNodes.Nodename
    {

        $domainCred = (New-Object System.Management.Automation.PSCredential ("$ScenarioData.DomainName\Administrator", (ConvertTo-SecureString $ConfigurationData.ScenarioData.DomainAdminPassword -AsPlainText -Force)))
        
        LocalConfigurationManager            
        {            
            ActionAfterReboot = 'ContinueConfiguration'            
            ConfigurationMode = 'ApplyOnly'            
            RebootNodeIfNeeded = $true            
        }

        #  Get-NetIPInterface will not work on PowerShell v4
        $interfaces =  Get-NetIPInterface -AddressFamily IPv4 | Where-Object -FilterScript { $_.InterfaceAlias -match "Ethernet" }
        foreach ($interface in $interfaces){
            xDnsServerAddress xDnsServerAddress
            {
                Address        = $ConfigurationData.ScenarioData.DnsServerAddress
                InterfaceAlias = $interface.InterfaceAlias
                AddressFamily  = 'IPv4'
                Validate       = $true
            }
        }

        Computer JoinDomain
        {
            Name       = $Node.ComputerName
            DomainName = $ConfigurationData.ScenarioData.DomainName
            Credential = $domainCred # Credential to join to domain
            Server     = $ConfigurationData.ScenarioData.DomainServerName
        }

    }
}