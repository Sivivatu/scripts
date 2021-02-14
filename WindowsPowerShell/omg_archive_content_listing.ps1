# $archive_date = Get-Date -Format "yyyy-MM-dd"

# Define initial variables for later use

$OMG_base = "C:\Users\paulj\OneDrive\Documents\scripts\OMGClick"
$OMG_folder = "OMGclick 4.0.4"
$OMG_screenshots = Join-Path  $OMG_base -ChildPath $OMG_folder | Join-Path -ChildPath "screenshots"
# $OMG_screenshots_dated = Join-Path $OMG_screenshots -ChildPath $archive_date
Write-Output $OMG_screenshots

$screenshots_archive = Join-Path $OMG_base -ChildPath "screenshots.zip"
# $backup_location = Join-Path $screenshots -Childpath $archive_date
# Get-ChildItem -Path $OMG_screenshots_dated | Compress-Archive -Update -DestinationPath $screenshots_archive

# Compress-Archive -Path $OMG_screenshots_dated -Update -DestinationPath $screenshots_archive

$OMG_screenshots_output = Join-Path $OMG_base -ChildPath "screenshots.txt"
# Expand-Archive -Path $screenshots_archive -DestinationPath $OMG_output -PassThru -WhatIf
& 'C:\Program Files\7-Zip\7z.exe' l $screenshots_archive > $OMG_screenshots_output

# $app = New-Object -COM 'Shell.Application'
# $zip_list = $app.NameSpace($screenshots_archive).Items() | Where-Object { $_.Name -like '*.txt' } | Select-Object -Expand Name

Write-Output $zip_list
# Move-Item $OMG_screenshots_dated "C:\"
# $DELETE = Join-Path "C:\" $archive_date
# # Remove-Item $nonOnedrivePath\$subFolder -Recurse -Force
# Remove-Item -LiteralPath $DELETE -Force -Recurse