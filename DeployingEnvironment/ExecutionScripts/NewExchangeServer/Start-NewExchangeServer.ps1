Param(
  [Parameter(HelpMessage="Please provide the path to configuration root folder", Position=1)]
  [string]$configurationRoot = "C:\Users\Administrator\Downloads\stark-forensics\DeployingEnvironment\ConfigurationScripts\",

  [Parameter(HelpMessage="Please provide the path to configuration script", Position=1)]
  [string]$configurationScript = "NewExchangeServer.ps1",

  [Parameter(HelpMessage="Please provide the path to configuration data")]
  [string]$configurationData = "NewExchangeServerConfigData.psd1"
)

. .\$configurationScript

$configurationPath = "$configurationRoot$configurationData"

NewExchangeServer -ConfigurationData $configurationPath
Set-DSCLocalConfigurationManager -Path .\NewExchangeServer –Verbose 
Start-DscConfiguration -Wait -Force -Path .\NewExchangeServer -Verbose
