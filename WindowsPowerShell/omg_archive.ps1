$archive_date = Get-Date -Format "yyyy-MM-dd"

$OMG_base = "C:\Users\paulj\OneDrive\Documents\scripts\OMGClick"

$OMG_folder = "OMGclick 4.0.4"
$OMG_screenshots = Join-Path  $OMG_base -ChildPath $OMG_folder | Join-Path -ChildPath "screenshots"
$OMG_screenshots_dated = Join-Path $OMG_screenshots -ChildPath $archive_date
Write-Output $OMG_screenshots

New-Item -Path $OMG_screenshots_dated -ItemType "directory"
join-path $OMG_screenshots -ChildPath "*.png" | Move-Item -Destination $OMG_screenshots_dated

$screenshots_archive = Join-Path $OMG_base -ChildPath "screenshots.zip"
# $backup_location = Join-Path $screenshots -Childpath $archive_date
# Get-ChildItem -Path $OMG_screenshots_dated | Compress-Archive -Update -DestinationPath $screenshots_archive

Compress-Archive -Path $OMG_screenshots_dated -Update -DestinationPath $screenshots_archive

Move-Item $OMG_screenshots_dated "C:\"
$DELETE = Join-Path "C:\" $archive_date
# Remove-Item $nonOnedrivePath\$subFolder -Recurse -Force
Remove-Item -LiteralPath $DELETE -Force -Recurse