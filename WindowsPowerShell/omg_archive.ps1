$archive_date = Get-Date -Format "yyyy-MM-dd"

$OMG_base = "C:\Users\paulj\OneDrive\Documents\scripts\OMGClick"

$OMG_folder = "OMGclick 4.0.2"
$OMG_screenshots = Join-Path  $OMG_base -ChildPath $OMG_folder | Join-Path -ChildPath "screenshots"
$OMG_screenshots_dated = Join-Path $OMG_screenshots -ChildPath $archive_date
Write-Output $OMG_screenshots

New-Item -Path $OMG_screenshots_dated -ItemType "directory"
join-path $OMG_screenshots -ChildPath "*.png" | Move-Item -Destination $OMG_screenshots_dated

$screenshots_archive = Join-Path $OMG_base -ChildPath "screenshots.zip"
# $backup_location = Join-Path $screenshots -Childpath $archive_date
# Get-ChildItem -Path $OMG_screenshots_dated | Compress-Archive -Update -DestinationPath $screenshots_archive

Compress-Archive -Path $OMG_screenshots_dated -Update -DestinationPath $screenshots_archive

# $screenshots_archive = Join-Path $OMG_base -ChildPath "screenshots_2.7z"
# $zipfilename = 'c:\cwRsync\backup.zip'
# $file = 'c:\cwRsync\backup.log'
# set-content $zipfilename ("PK" + [char]5 + [char]6 + ("$([char]0)" * 18))
# (dir $zipfilename).IsReadOnly = $false
# $zipfile = (New-Object -ComObject shell.application).NameSpace($zipfilename)
# $zipfile.MoveHere($file.FullName)