$Packages = 'googlechrome', 
'git', 
'vscode', 
'teracopy', 
'webp', 
'7zip.install', 
'microsoft-edge-insider-dev', 
'adobereader', 
'parsec', 
'microsoft-windows-terminal'


# choco upgrade all

ForEach ($PackageName in $Packages) {
    choco upgrade $PackageName -y
}
