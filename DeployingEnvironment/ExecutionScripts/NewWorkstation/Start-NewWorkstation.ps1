Param(
  [Parameter(HelpMessage="Please provide the path to configuration script", Position=1)]
  [string]$configurationScript = "NewWorkstation.ps1",

  [Parameter(HelpMessage="Please provide the path to configuration data")]
  [string]$configurationData = "NewWorkstationConfigData.psd1"
)

. .\$configurationScript

NewWorkstation -ConfigurationData $configurationData
Start-DscConfiguration -Wait -Force -Path .\NewWorkstation -Verbose