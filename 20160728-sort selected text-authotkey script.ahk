; Thanks : https://misterhenson.wordpress.com/2013/02/07/autohotkey-define-a-hotkey-to-sort-selected-text-lines/

#v::
Clipboard = ; Must be blank for detection to work.
Send ^c
ClipWait 2
if ErrorLevel
return
Sort Clipboard
Send ^v
return