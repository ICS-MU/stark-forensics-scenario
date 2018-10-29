Param(
  [Parameter(HelpMessage="Please provide the path to configuration script", Position=1)]
  [string]$configurationScript="CopyResourcesToTargetNodes.ps1",

  [Parameter(HelpMessage="Please provide the path to configuration data")]
  [string]$configurationData="CopyResourcesToTargetNodesConfigData.psd1"
)

. .\$configurationScript

CopyResourcesToTargetNodes -ConfigurationData $configurationData
Start-DscConfiguration -Wait -Force -Path .\CopyResourcesToTargetNodes -Verbose
