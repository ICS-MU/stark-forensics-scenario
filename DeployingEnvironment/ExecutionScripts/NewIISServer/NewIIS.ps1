# A configuration to Create IIS server
configuration NewIIS
{
    # Import the module that defines custom resources
    Import-DscResource -Module PSDesiredStateConfiguration

    Node $AllNodes.Where{$_.Role -eq "IIS Server"}.Nodename
    {
        # Install the IIS role
        WindowsFeature IIS
        {
            Ensure          = 'Present'
            Name            = 'Web-Server'
        }

        # Install the ASP .NET 4.5 role
        WindowsFeature AspNet45
        {
            Ensure          = 'Present'
            Name            = 'Web-Asp-Net45'
        }
	    
        # Install IIS Management Tools
        WindowsFeature IISManagementTools
        {
            Ensure = "Present"
            Name = "Web-Mgmt-Tools"
            DependsOn='[WindowsFeature]IIS'
        }
     }
}