$source = "C:\Users\paulj\Dropbox"
$destination = "C:\Users\paulj\Nextcloud\Dropbox"

Write-Output "identifying files from $source"
$source_contents = Get-ChildItem -Recurse -path $source

Write-Output "identifying files from $destination"
$destination_contents = Get-ChildItem -Recurse -path $destination

Write-Output "Comparing files from $source with $destination"
$result = Compare-Object -ReferenceObject $source_contents -DifferenceObject $destination_contents
Write-Output $result