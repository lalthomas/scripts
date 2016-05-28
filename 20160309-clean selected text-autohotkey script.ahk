; Author : Lal Thomas
 
^!c::  ; ctrl+alt+c cleans the selected text
{

	Clipboard:= ""
	Send, ^c ;copies selected text
	ClipWait
	Clipboard := RegExReplace(Clipboard, "[^[:alpha:]]", " ")
	Clipboard := RegExReplace(Clipboard, "[\s\s]", " ")
	Clipboard := Trim(Clipboard)
	Send %Clipboard%
	return

}
