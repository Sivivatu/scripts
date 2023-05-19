param (
    [string]$downloadFolder = "C:\Users\paulj\Downloads",
    [int]$daysToArchive = 14
)

# Define file extensions and their corresponding folder names
$extensionMapping = @{
    # Alteryx Files
    ".yxdb" = "Alteryx Files"
    ".yxmc" = "Alteryx Files"
    ".yxmd" = "Alteryx Files"
    ".yxi" = "Alteryx Files"
    
    # Archive Files
    ".zip" = "Archives"
    ".iso"  = "Archives"
    ".7z"  = "Archives"
    ".tar"  = "Archives"
    ".gz"  = "Archives"
    ".msi"  = "Archives"
    ".exe"  = "Archives"
    
    # Images
    ".jpg" = "Images"
    ".jpeg"	= "Images"
    ".jpe" = "Images"
    ".jif" = "Images"
    ".jfif" = "Images"
    ".jfi"	= "Images"
    ".png" = "Images"
    ".gif"	= "Images"
    ".webp"	= "Images"
    ".tiff"	= "Images"
    ".tif"	= "Images"
    ".psd"	= "Images"
    ".raw"	= "Images"
    ".arw" = "Images"
    ".cr2"	= "Images"
    ".nrw"	= "Images"
    ".k25"	= "Images"
    ".bmp"	= "Images"
    ".dib"	= "Images"
    ".heif"	= "Images"
    ".heic" = "Images"
    ".ind"	= "Images"
    ".indd"	= "Images"
    ".indt"	= "Images"
    ".jp2"	= "Images"
    ".j2k"	= "Images"
    ".jpf"	= "Images"
    ".jpx"	= "Images"
    ".jpm"	= "Images"
    ".mj2"	= "Images"
    ".svg"	= "Images"
    ".svgz"	= "Images"
    ".ai"	= "Images"
    ".eps" = "Images"
    ".ico" = "Images"
    
    # Documents and spreadsheets
    ".pdf" = "Document Files"
    ".txt" = "Document Files"
    ".doc" = "Document Files"
    ".docx" = "Document Files"
    ".odt" = "Document Files"
    ".csv" = "Document Files"
    ".xls" = "Document Files"
    ".xlsx" = "Document Files"
    ".ppt" = "Document Files"
    ".pptx" = "Document Files"
    
    # Add more extensions and folder names as needed
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

# Get the files to archive based on the cutoff date
$filesToArchive = Get-ChildItem -Path $downloadFolder -File -Recurse | Where-Object { $_.LastWriteTime -lt $cutoffDate }

# Create the zip file path
$zipFilePath = Join-Path -Path $zipFolderPath -ChildPath ($zipFolderName + ".zip")

# Archive the files
if ($filesToArchive.Count -gt 0) {
    Compress-Archive -Path $filesToArchive.FullName -DestinationPath $zipFilePath
}
