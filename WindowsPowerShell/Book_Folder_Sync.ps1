# $archive_date = Get-Date -Format "yyyy-MM-dd"

$onedrive_book = "C:\Users\paulj\OneDrive\Documents\_Book\Alteryx For Data Engineers"
$googledrive_book = "H:\My Drive\Book\Alteryx for Data Engineers\Book Chapters"

# $OMG_screenshots = Join-Path  $OMG_base -ChildPath $OMG_folder | Join-Path -ChildPath "screenshots"
# $OMG_screenshots_dated = Join-Path $OMG_screenshots -ChildPath $archive_date
# Write-Output $OMG_screenshots

# New-Item -Path $OMG_screenshots_dated -ItemType "directory"
# join-path $OMG_screenshots -ChildPath "*.png" | Move-Item -Destination $OMG_screenshots_dated

# $screenshots_archive = Join-Path $OMG_base -ChildPath "screenshots.zip"
# # $backup_location = Join-Path $screenshots -Childpath $archive_date
# # Get-ChildItem -Path $OMG_screenshots_dated | Compress-Archive -Update -DestinationPath $screenshots_archive

# Compress-Archive -Path $OMG_screenshots_dated -Update -DestinationPath $screenshots_archive



# # update log of screenshots archive
# $OMG_screenshots_output = Join-Path $OMG_base -ChildPath "screenshots.txt"
# # Expand-Archive -Path $screenshots_archive -DestinationPath $OMG_output -PassThru -WhatIf
# & 'C:\Program Files\7-Zip\7z.exe' l $screenshots_archive > $OMG_screenshots_output

Robocopy.exe --help