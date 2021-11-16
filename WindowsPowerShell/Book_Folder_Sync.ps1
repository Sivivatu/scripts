# $archive_date = Get-Date -Format "yyyy-MM-dd"

$source_onedrive_book = "C:\Users\paulj\OneDrive\Documents\_Book\Alteryx For Data Engineers"
$dest_googledrive_book = "H:\My Drive\Book\Alteryx for Data Engineers\Book Chapters"
$files = "*.docx" # files in folder to copy
$copy_control = "/COPYALL /B" # is supposed to take all document properties
$options = "/NDL" # /R:2 

# example command to reference
# robocopy "$source $dest $what $options /LOG:MyLogfile.txt"
Write-Host "Test sync : Robocopy.exe $source_onedrive_book $dest_googledrive_book $files $copy_control $options /LOG+:synclog.txt"
Robocopy.exe "$source_onedrive_book" "$dest_googledrive_book" $files /LOG+:synclog.txt #$copy_control # $options # 