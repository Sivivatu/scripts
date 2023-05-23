param (
    [string]$downloadFolder = "C:\Users\paulj\Downloads\download_test",
    [int]$daysToArchive = 1,
    [bool]$enableLogging = $true,
    [string]$extensionMappingFile = "C:\Users\paulj\OneDrive\Documents\scripts\WindowsPowerShell\extensionMapping.csv",
    [bool]$enableArchiving = $true,
    [string]$archiveFolderName = "Archives"
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
$zipFolderPath = Join-Path -Path $downloadFolder -ChildPath $archiveFolderName
$logFilePath = Join-Path -Path $zipFolderPath -ChildPath $zipFolderName + ".log"

# Create the zip folder if it doesn't exist
if (-not (Test-Path -Path $zipFolderPath -PathType Container)) {
    New-Item -Path $zipFolderPath -ItemType Directory | Out-Null
}

# Get the files to archive based on the cutoff date, excluding the zip folders matching the pattern Archive_yyyy_mm.zip
$filesToArchive = Get-ChildItem -Path $downloadFolder -File -Recurse | Where-Object {
    $_.LastWriteTime -lt $cutoffDate -and -not ($_ -is [System.IO.DirectoryInfo] -and $_.Name -like "Archive_????_??.zip") -and $_.FullName -notlike "$zipFolderPath\*"
}

# Archive the files if enabled
if ($enableArchiving -and $filesToArchive.Count -gt 0) {
    $zipFilePath = Join-Path -Path $zipFolderPath -ChildPath ($zipFolderName + ".zip")
    $tempFolder = Join-Path -Path $downloadFolder -ChildPath "TempArchive"

    # Create the temporary archive folder if it doesn't exist
    if (-not (Test-Path -Path $tempFolder -PathType Container)) {
        New-Item -Path $tempFolder -ItemType Directory | Out-Null
    }

    # Move the files to archive into the temporary folder while preserving relative paths
    foreach ($file in $filesToArchive) {
        $relativePath = $file.FullName.Substring($downloadFolder.Length + 1)
        $destinationPath = Join-Path -Path $tempFolder -ChildPath $relativePath

        # Create the destination folder if it doesn't exist
        $destinationFolder = Split-Path -Path $destinationPath
        if (-not (Test-Path -Path $destinationFolder -PathType Container)) {
            New-Item -Path $destinationFolder -ItemType Directory | Out-Null
        }

        # Move the file to the temporary folder
        Move-Item -Path $file.FullName -Destination $destinationPath
    }

    # Create the zip file by compressing the temporary folder
    Compress-Archive -Path $tempFolder -DestinationPath $zipFilePath -CompressionLevel Optimal -Force

    # Remove the temporary folder
    Remove-Item -Path $tempFolder -Force -Recurse

    # Delete the files that have been added to the zip folder
    foreach ($fileToArchive in $filesToArchive) {
        if (Test-Path -Path $fileToArchive.FullName) {
            Remove-Item -Path $fileToArchive.FullName -Force
        }
    }
}

# Create the log message with folder counts
$logMessage = "Script execution completed on $(Get-Date)`n"

# Loop through each folder in the extension mapping
foreach ($folderName in $extensionMapping.Values | Get-Unique) {
    $folderPath = Join-Path -Path $downloadFolder -ChildPath $folderName
    $fileCount = @(Get-ChildItem -Path $folderPath -File).Count
    $logMessage += "Folder: $folderPath, File Count: $fileCount`n"
}

# Append the log message to the log file
$logMessage | Out-File -FilePath $logFilePath -Append
