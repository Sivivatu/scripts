$Packages = 'googlechrome', 
# 'microsoft-edge-insider-dev',
'microsoft-edge',
# Code tools
'git', 
'vscode', 
'gh',
'github-desktop',
'microsoft-windows-terminal',
'powershell-core',
'powershell-preview',
'awscli',
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
# 'fileseek', # possible future file searching option. wanted on 17 Feb 2021
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

$uninstall_update = 'google-drive-file-stream', 'vscode'

ForEach ($PackageName in $uninstall_update) {
    choco uninstall $PackageName -y
}

ForEach ($PackageName in $uninstall_update) {
    choco upgrade $PackageName -y
}