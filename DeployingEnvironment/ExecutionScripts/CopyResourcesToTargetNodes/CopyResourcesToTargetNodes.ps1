configuration CopyResourcesToTargetNodes
{
    Node $AllNodes.Nodename {
    Get-ChildItem $ConfigurationData.ScenarioData.SharedFolder -Filter *.zip | 
        Foreach-Object {
           Archive $($_.Name)
            {
                Destination = "C:\Program Files\WindowsPowerShell\Modules"
                Path = $_.FullName
                Ensure = "Present"
            }
        }      
    }  
}

