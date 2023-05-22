param (
    [string]$downloadFolder = "C:\Users\paulj\Downloads",
    [int]$daysToArchive = 14,
    [bool]$enableLogging = $true,
    [string]$extensionMappingFile = ".\WindowsPowerShell\extensionMapping.csv"
)

# Define file extensions and their corresponding folder names
$extensionMapping = @{}

if (Test-Path -Path $extensionMappingFile -PathType Leaf) {
    $extensionMappingData = Import-Csv -Path $extensionMappingFile
    foreach ($mapping in $extensionMappingData) {
        $extensionMapping[$mapping.Extension] = $mapping.FolderName
    }
}

if ($enableLogging) {
    foreach ($key in $extensionMapping.Keys) {
        Write-Debug "Extension mapping - Extension: $key, FolderName: $($extensionMapping[$key])"
    }
}

# Create folders if they don't exist
foreach ($folderName in $extensionMapping.Values | Get-Unique) {
    $folderPath = Join-Path -Path $downloadFolder -ChildPath $folderName
    if (-not (Test-Path -Path $folderPath -PathType Container)) {
        New-Item -Path $folderPath -ItemType Directory | Out-Null
    }
}

# Move files to the appropriate folders
Get-ChildItem -Path $downloadFolder -File -Recurse | ForEach-Object {
    $extension = $_.Extension.ToLower()
    if ($extensionMapping.ContainsKey($extension)) {
        $destinationFolder = Join-Path -Path $downloadFolder -ChildPath $extensionMapping[$extension]
        Move-Item -Path $_.FullName -Destination $destinationFolder
    }
}

# Determine the cutoff date for archiving
$cutoffDate = (Get-Date).AddDays(-$daysToArchive)

# Create the zip folder name based on the current month and year
$zipFolderName = "Archive_" + (Get-Date).ToString("yyyy_MM")

# Create the zip folder path
$zipFolderPath = Join-Path -Path $downloadFolder -ChildPath $zipFolderName

# Create the zip folder if it doesn't exist
if (-not (Test-Path -Path $zipFolderPath -PathType Container)) {
    New-Item -Path $zipFolderPath -ItemType Directory | Out-Null
}

# Get the files to archive based on the cutoff date, excluding the zip folders matching the pattern Archive_yyyy_mm.zip
$filesToArchive = Get-ChildItem -Path $downloadFolder -File -Recurse | Where-Object {
    $_.LastWriteTime -lt $cutoffDate -and -not ($_ -is [System.IO.DirectoryInfo] -and $_.Name -like "Archive_????_??.zip")
}

# Archive the files if enabled
# FIXME: this section is not creating the zip file.
if ($enableArchiving -and $filesToArchive.Count -gt 0) {
    $zipFilePath = Join-Path -Path $zipFolderPath -ChildPath ($zipFolderName + ".zip")
    
    # Create the zip file and add files with their relative paths
    Add-Type -AssemblyName System.IO.Compression.FileSystem
    [System.IO.Compression.ZipFileExtensions]::CreateFromDirectory($downloadFolder, $zipFilePath, "Optimal", $true)

    # Delete the files that have been added to the zip folder
    foreach ($fileToArchive in $filesToArchive) {
        if (Test-Path -Path $fileToArchive.FullName) {
            Remove-Item -Path $fileToArchive.FullName -Force
        }
    }
}
