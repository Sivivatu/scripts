:: Create running variables

SET downloads_path=C:\Users\Paul\Downloads\
SET log=C:\Users\Paul\Documents\maintenance\log\
SET SAVESTAMP=%DATE:/=_%
:: echo %downloads_path%

echo %DATE%-%TIME% - Starting downloads cleaup > %log%download_cleanup_%SAVESTAMP%.log

:: move all old files into archive folder
robocopy %download% %download%archive_%SAVESTAMP% /move /minlad:30 /s /e >> %log%download_cleanup_%SAVESTAMP%.log

"C:\Program Files\7-Zip\7z.exe" a %download%download_archive_%SAVESTAMP%.7z %download%archive_%SAVESTAMP%\ -r >> %log%download_cleanup_%SAVESTAMP%.log
::forfiles -p %downloads_path% -s -m *.* /D -30 /C ::"cmd /c del @path"
:: Cleans out files in the specified directory that end in .tsbak extension and are older than 14 days
:: If you are running this script weekly, this ensures that only 2 backup files are saved.
:: You will likely want to adjust this if you plan to run this script more frequently.
