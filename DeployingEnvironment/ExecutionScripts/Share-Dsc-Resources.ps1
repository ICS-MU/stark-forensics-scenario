<#
.DESCRIPTION
    Script install specified DSC resources and also add these resources to the shared folder as zip archives 
.NOTES
     Author     : Vadim Janovskij
#>

# Name of the folder, that will be shared
$sharedFolderName = 'DscSharedFolder'
# Path where DSc resources are saved after install
$path_where_modules_are_saved = 'C:\Program Files\WindowsPowerShell\Modules'

# List of modules that should be installed and shared
$dsc_modules = "xPSDesiredStateConfiguration", "xActiveDirectory", "xNetworking"

New-Item -ItemType directory -Path C:\$sharedFolderName
New-SmbShare -Name sharedFolderName -Path C:\$sharedFolderName -Description 'File share for DSC modules' -FullAccess everyone -Verbose
foreach ($dsc_module in $dsc_modules){
    $newest_version_of_the_module = Find-Module $dsc_module
    Install-Module $newest_version_of_the_module -Verbose -Force
    Compress-Archive -Path $path_where_modules_are_saved\$($newest_version_of_the_module.Name) -DestinationPath C:\$sharedFolderName\$($newest_version_of_the_module.Name)_$($newest_version_of_the_module.Version.Major).$($newest_version_of_the_module.Version.Minor).$($newest_version_of_the_module.Version.Build).$($newest_version_of_the_module.Version.Revision).zip -Verbose
}