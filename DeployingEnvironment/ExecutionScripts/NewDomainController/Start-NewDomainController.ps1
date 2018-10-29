Param(
  [Parameter(HelpMessage="Please provide the path to configuration root folder", Position=1)]
  [string]$configurationRoot = "C:\Users\Administrator\Downloads\stark-forensics\DeployingEnvironment\ConfigurationScripts\",

  [Parameter(HelpMessage="Please provide the path to configuration script", Position=1)]
  [string]$configurationScript = "NewDomainController.ps1",

  [Parameter(HelpMessage="Please provide the path to configuration data")]
  [string]$configurationData = "NewDomainControllerConfigData.psd1"
)

. .\$configurationScript

$configurationPath = "$configurationRoot$configurationData"

NewDomainController -ConfigurationData $configurationPath
Set-DSCLocalConfigurationManager -Path .\NewDomainController -Verbose 
Start-DscConfiguration -Wait -Force -Path .\NewDomainController -Verbose
