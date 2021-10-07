$rootPath = "C:\Users\paulj\OneDrive\Documents"

# $empty_folders =Get-ChildItem $rootPath | ForEach-Object {
#     if( $_.psiscontainer -eq $true){
#        if((Get-ChildItem $_.FullName) -eq $null){$_.FullName}
#     }
# }

foreach($childItem in (Get-ChildItem $rootPath -Recurse))
{
	# if it's a folder AND does not have child items of its own
	if( ($childItem.PSIsContainer) -and (!(Get-ChildItem -Recurse -Path $childItem.FullName)))
	{
		# Delete it
		# Remove-Item $childItem.FullName -Confirm:$false
	}
}