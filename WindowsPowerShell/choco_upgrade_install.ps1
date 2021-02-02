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
'google-drive-file-stream', 
'powertoys',
'adobereader', 
'rescuetime',
'mobaXterm',
'whatsapp',
'zoom',
'filebot',
'sdio',
# Gaming tools
'parsec', #needed? Replace use with Guac?
'discord',
'steam'

# choco upgrade all

ForEach ($PackageName in $Packages) {
    choco upgrade $PackageName -y
}
