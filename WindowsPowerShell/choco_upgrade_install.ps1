$Packages = 'googlechrome', 
# 'microsoft-edge-insider-dev',
'microsoft-edge',
# Code tools
'git', 
'vscode', 
'gh',
'microsoft-windows-terminal',
'powershell-core',
'powershell-preview',
# utilities
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
# Gaming tools
'parsec', #needed? Replace use with Guac?
'discord',
'steam',
'msiafterburner',
'autohotkey',
'obs-studio'

# choco upgrade all

ForEach ($PackageName in $Packages) {
    choco upgrade $PackageName -y
}

$uninstall_update = 'google-drive-file-stream'

ForEach ($PackageName in $uninstall_update) {
    choco upgrade $PackageName -y
}

ForEach ($PackageName in $uninstall_update) {
    choco upgrade $PackageName -y
}