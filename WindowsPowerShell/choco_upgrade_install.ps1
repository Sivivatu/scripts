$Packages = 'googlechrome', 
# 'microsoft-edge-insider-dev',
'microsoft-edge',
# Code tools
'python',
'git', 
'vscode', 
'gh',
'github-desktop',
'microsoft-windows-terminal',
'powershell-core',
'powershell-preview',
'awscli',
'dbeaver',
# utilities
'zoomit',
'teracopy', 
'webp', 
'7zip.install',
'powertoys',
'adobereader', 
'rescuetime',
'mobaXterm',
'whatsapp',
'zoom',
'filebot',
'sdio',
'pia',
'fileseek',
# Gaming tools
'discord',
'steam',
'autohotkey',
'obs-studio'

# choco upgrade all

ForEach ($PackageName in $Packages) {
    choco upgrade $PackageName -y
}

# $uninstall_update = 'google-drive-file-stream'
# # 'msiafterburner'

# ForEach ($PackageName in $uninstall_update) {
#     choco uninstall $PackageName -y
# }

# ForEach ($PackageName in $uninstall_update) {
#     choco upgrade $PackageName -y
# }