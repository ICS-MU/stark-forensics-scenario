Param(
  [Parameter(HelpMessage="Please provide the path to configuration root folder", Position=1)]
  [string]$configurationRoot = "C:\Users\Administrator\Downloads\stark-forensics\DeployingEnvironment\ConfigurationScripts\",

  [Parameter(HelpMessage="Please provide the path to configuration script", Position=1)]
  [string]$configurationScript = "NewIIS.ps1",

  [Parameter(HelpMessage="Please provide the path to configuration data")]
  [string]$configurationData = "IISConfigData.psd1"
)

. .\$configurationScript

$configurationPath = "$configurationRoot$configurationData"

NewIIS -ConfigurationData $configurationPath
Set-DSCLocalConfigurationManager -Path .\NewIIS –Verbose            
Start-DscConfiguration -Wait -Force -Path .\NewIIS -Verbose 
