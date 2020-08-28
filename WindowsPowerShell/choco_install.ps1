$Packages = 'googlechrome', 'git', 'vscode', 'teracopy'

ForEach ($PackageName in $Packages)
    {
        choco install $PackageName -y
    }