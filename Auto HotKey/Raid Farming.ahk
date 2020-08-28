#MaxThreadsPerHotkey 2
SetTitleMatchMode, 2
F5::
Toggle := !Toggle
loop
{
    If not Toggle
        break
    WinGetActiveTitle, Title
    WinActivate, ahk_exe Raid.exe
   
    ControlSend, , r, ahk_exe Raid.exe
    WinActivate, %Title%
 
sleep, 5000
}
return