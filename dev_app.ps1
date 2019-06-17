# Description: Boxstarter Script
# Author: Microsoft
# Common settings for azure devops
choco config set cacheLocation d:\chocolatey

Disable-UAC
$ConfirmPreference = "None" #ensure installing powershell modules don't prompt on needed dependencies

# Get the base URI path from the ScriptToCall value
$bstrappackage = "-bootstrapPackage"
$helperUri = $Boxstarter['ScriptToCall']
$strpos = $helperUri.IndexOf($bstrappackage)
$helperUri = $helperUri.Substring($strpos + $bstrappackage.Length)
$helperUri = $helperUri.TrimStart("'", " ")
$helperUri = $helperUri.TrimEnd("'", " ")
$helperUri = $helperUri.Substring(0, $helperUri.LastIndexOf("/"))
$helperUri += "/scripts"
write-host "helper script base URI is $helperUri"

function executeScript {
    Param ([string]$script)
    write-host "executing $helperUri/$script ..."
	iex ((new-object net.webclient).DownloadString("$helperUri/$script"))
}

if((test-path -path d:\) -and !(test-path -path d:\Downloads)) {
write-host "moving libraries..."
Move-LibraryDirectory "My Video" "D:\Videos"
Move-LibraryDirectory "My Pictures" "D:\Pictures"
Move-LibraryDirectory "Desktop" "D:\Desktop"
Move-LibraryDirectory "Favorites" "D:\Favorites"
Move-LibraryDirectory "My Music" "D:\Music"
Move-LibraryDirectory "Personal" "D:\Documents"
Move-LibraryDirectory "Downloads" "D:\Downloads"
#Move-LibraryDirectory "Searches" "D:\Searches"
#Move-LibraryDirectory "Links" "D:\Links"
}

#--- Setting up Windows ---
executeScript "FileExplorerSettings.ps1";
executeScript "SystemConfiguration.ps1";
executeScript "RemoveDefaultApps.ps1";
executeScript "CommonDevTools.ps1";
executeScript "Browsers.ps1";

#executeScript "HyperV.ps1";
#RefreshEnv
#executeScript "WSL.ps1";
#RefreshEnv
#executeScript "Docker.ps1";

choco install -y powershell-core
choco install -y azure-cli
choco install -y azcopy
#choco install -y azurepowershell
Install-Module -Force Az
choco install -y microsoftazurestorageexplorer
choco install -y terraform

#--- Tools ---
#--- Installing VS and VS Code with Git
# See this for install args: https://chocolatey.org/packages/VisualStudio2017Community
# https://docs.microsoft.com/en-us/visualstudio/install/workload-component-id-vs-community
# https://docs.microsoft.com/en-us/visualstudio/install/use-command-line-parameters-to-install-visual-studio#list-of-workload-ids-and-component-ids
# visualstudio2017community
# visualstudio2017professional
# visualstudio2017enterprise

choco install -y visualstudio2019enterprise --package-parameters="'--add Microsoft.VisualStudio.Component.Git'"
Update-SessionEnvironment #refreshing env due to Git install

#--- UWP Workload and installing Windows Template Studio ---
choco install -y visualstudio2019-workload-azure
choco install -y visualstudio2019-workload-netcoretools
choco install -y visualstudio2019-workload-netweb
choco install -y visualstudio2019-workload-netcrossplat
#choco install -y visualstudio2019-workload-universal
#choco install -y visualstudio2019-workload-manageddesktop
#choco install -y visualstudio2019-workload-nativedesktop

#executeScript "WindowsTemplateStudio.ps1";
#executeScript "GetUwpSamplesOffGithub.ps1";

choco install -y chocolateygui
choco install -y revo-uninstaller

#Other essential tools
choco install -y dontnet3.5
#choco install -y adobereader
choco install -y rdmfree #rdcman
choco install -y flashplayerplugin
choco install -y autohotkey
#choco install -y autohotkey-compiler
choco install -y scite4autohotkey
#choco install -y office365proplus 
choco install -y onenote
choco install -y trillian 
choco install -y wiztree 
choco install -y windirstat 
choco install -y freedownloadmanager
choco install -y vdhcoapp
#choco install -y microsoft-teams 
choco install -y foxitreader
choco install -y gimp
choco install -y glaryutilities-free
choco install -y synctrayzor
choco install -y notepadplusplus
choco install -y vlc
choco install -y jre8
choco install -y javaruntime
choco install -y lastpass
choco install -y myharmony
choco install -y openvpn
choco install -y pia
choco install -y royalts
choco install -y rainmeter
choco install -y pdf24 #cutepdf
choco install -y bingdesktop
choco install -y winmerge
choco install -y picard
choco install -y putty

#Other dev tools
choco install -y fiddler
choco install -y NugetPackageExplorer
choco install -y windbg
choco install -y linqpad
#choco install -y ncrunch.vs2017 # --version 3.22.1 
choco install -y resharper-platform
#choco install -y githubforwindows

#--- reenabling critial items ---
Enable-UAC
Enable-MicrosoftUpdate
Install-WindowsUpdate -acceptEula
