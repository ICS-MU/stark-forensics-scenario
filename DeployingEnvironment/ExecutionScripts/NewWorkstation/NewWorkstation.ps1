Configuration NewWorkStation
{
    Import-DscResource -Module xChrome
    Node $AllNodes.Where{$_.Role -contains"Workstation"}.Nodename
    {
        MSFT_xChrome chrome
    	{
    	   Language = $AllNodes.$Language
    	   LocalPath = "$env:USERPROFILE\Downloads"
    	}
    }
}
