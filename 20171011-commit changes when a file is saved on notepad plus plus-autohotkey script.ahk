
; thanks : https://superuser.com/a/390820/318277

#IfWinActive, ahk_class Notepad++
^s:: ;Ctrl+S
{
    Send, ^s{F5}
    WinWaitActive, Run...
    Send, {Enter}
    return
}
#IfWinActive