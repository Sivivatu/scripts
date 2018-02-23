<#

"C:\Program Files\7-Zip\7z.exe" a %downloads_path%download_archive_%SAVESTAMP%.7z %downloads_path%archive_%SAVESTAMP%\ -r >> %log%download_cleanup_%SAVESTAMP%.log
::forfiles -p %downloads_path% -s -m *.* /D -30 /C ::"cmd /c del @path"
:: Cleans out files in the specified directory that end in .tsbak extension and are older than 14 days
:: If you are running this script weekly, this ensures that only 2 backup files are saved.
:: You will likely want to adjust this if you plan to run this script more frequently.

rmdir /s /q %downloads_path%archive_%SAVESTAMP% >> %log%download_cleanup_%SAVESTAMP%.log

#>




# Varibles for later workflow processes

Set-Variable -Name savetimestamp -Value $(Get-Date -f yyyyMMdd)
Set-Variable -Name downloads_path -Value C:\Users\Paul\Downloads\
Set-Variable -Name logfolder -Value C:\Users\Paul\Documents\maintenance\log\
Set-Variable -Name logfile -Value $logfolder"download_cleanup_"$savetimestamp.log
Set-Variable -Name archivefolder -Value $downloads_path"archive_"$savetimestamp


# Initialise function to write to logs
Function LogWrite
{
   Param ([string]$logstring)

   Add-content $Logfile -value $logstring
}

LogWrite $(Get-Date)
LogWrite $("Starting downloads cleanup")

LogWrite $("Moving files older than 30 days to temp folder")
robocopy $downloads_path $archivefolder /move /minlad:30 /s /e /LOG+:$logfile

#are able to move the files to the temp folder but need to work out how to archive, zip and delete the old files
# the & function allows for interperating stings as a file path.
# & "C:\Program Files\7-Zip\7z.exe" a -r $archivefolder"download_archive_"$savetimestamp".7z" %downloads_path%archive_%SAVESTAMP%\ 