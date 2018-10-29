Param(
  [Parameter(HelpMessage="Please provide the path to configuration root folder", Position=1)]
  [string]$configurationRoot = "C:\Users\Administrator\Downloads\stark-forensics\DeployingEnvironment\ConfigurationScripts\",

  [Parameter(HelpMessage="Please provide the path to configuration script", Position=1)]
  [string]$configurationScript = "AddToDomain.ps1",

  [Parameter(HelpMessage="Please provide the path to configuration data")]
  [string]$configurationData = "AddToDomainConfigData.psd1"
)

. .\$configurationScript

$configurationPath = "$configurationRoot$configurationData"

AddToDomain -ConfigurationData $configurationPath
Set-DSCLocalConfigurationManager -Path .\AddToDomain -Verbose 
Start-DscConfiguration -Wait -Force -Path .\AddToDomain -Verbose
