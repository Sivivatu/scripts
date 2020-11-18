$Packages = 'googlechrome', 'git', 'vscode', 'teracopy', 'webp', '7zip.install', 'microsoft-edge-insider-dev'

ForEach ($PackageName in $Packages)
    {
        choco upgrade $PackageName -y
    }

# choco upgrade all