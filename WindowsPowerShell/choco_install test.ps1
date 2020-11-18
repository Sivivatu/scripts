choco search webp -exact

$Packages = 'googlechrome', 'git', 'vscode', 'teracopy', 'webp', 'gh'

ForEach ($PackageName in $Packages)
    {
        choco install $PackageName -y
    }

choco upgrade all

choco list -lo | Where-object { $_.ToLower().StartsWith("SomeName".ToLower()) }

choco search webp -exact | Where-Object {$_}
if($result -ne $null){
$parts = $result.Split(' ');
	return $parts[1] -eq $this.Version;
}
return $false;