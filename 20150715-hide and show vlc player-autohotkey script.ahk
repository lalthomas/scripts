#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#InstallKeybdHook
#Persistent
#HotkeyInterval,100
#NoEnv
SetKeyDelay, –1
SetTitleMatchMode, 2 ; Makes matching the titles easier
SendMode Input
SetWorkingDir %A_ScriptDir%

F6::
{
; put the hiding windows stuff here
WinHide, VLC media player
Return
}

F7::
{
; put the functions to show everything again here
DetectHiddenWindows, On
WinShow, VLC media player
Return
}
