# Downloads folder Cleanup
$Folder = "C:\Users\paulj\Downloads"
$date = Get-Date -UFormat "%Y-%m-%d"

#Delete exe files older than 7 days
Get-ChildItem $Folder -Recurse -Force -ea 0 |
Where-Object {!$_.PsIsContainer -and $_.LastWriteTime -lt (Get-Date).AddDays(-7) -and $_.extension -eq ".exe"} |
ForEach-Object {
   $_ | Remove-Item -Force
   $_.FullName | Out-File C:\log\deletedlog.txt -Append
}


# #Delete files older than 6 months
# Get-ChildItem $Folder -Recurse -Force -ea 0 |
# Where-Object {!$_.PsIsContainer -and $_.LastWriteTime -lt (Get-Date).AddDays(-180)} |
# ForEach-Object {
#    $_ | Remove-Item -Force
#    $_.FullName | Out-File C:\log\deletedlog.txt -Append
# }

# # Documents empty folder cleanup
# $folder = "C:\Users\paulj\OneDrive\Documents"

# #Delete empty folders and subfolders
# Get-ChildItem $Folder -Recurse -Force -ea 0 |
# Where-Object {$_.PsIsContainer -eq $True} |
# Where-Object {$_.getfiles().count -eq 0} |
# ForEach-Object {
#     $_ | Remove-Item -Force
#     $_.FullName | Out-File C:\log\deletedlog.txt -Append
# }