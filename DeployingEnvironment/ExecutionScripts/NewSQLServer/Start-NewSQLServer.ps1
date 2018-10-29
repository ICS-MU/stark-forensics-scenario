Param(
  [Parameter(HelpMessage="Please provide the path to configuration root folder", Position=1)]
  [string]$configurationRoot = "C:\Users\Administrator\Downloads\stark-forensics\DeployingEnvironment\ConfigurationScripts\",

  [Parameter(HelpMessage="Please provide the path to configuration script", Position=1)]
  [string]$configurationScript = "NewSQLServer.ps1",

  [Parameter(HelpMessage="Please provide the path to configuration data")]
  [string]$configurationData = "NewSQLServerConfigData.psd1"
)

. .\$configurationScript

$configurationPath = "$configurationRoot$configurationData"

NewSQLServer -ConfigurationData $configurationPath
Start-DscConfiguration -Wait -Force -Path .\NewSQLServer -Verbose
