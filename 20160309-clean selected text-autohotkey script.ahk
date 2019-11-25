; Author : Lal Thomas
 
^!c::  ; ctrl+alt+c cleans the selected text
{

	Clipboard:= ""
	Send, ^c ;copies selected text
	ClipWait
		
	; Normal Comment cleanup
	
		; replace all non letters with space
		Clipboard := RegExReplace(Clipboard, "[^[:alpha:]]", " ")
	
		; replace all double space with single space	
		Clipboard := RegExReplace(Clipboard, "[\s\s]", " ")
	
		; trim starting and ending spacing
		Clipboard := Trim(Clipboard)
	
	
	;Windows path clean up

		;replace :\\ with -
		; Clipboard := RegExReplace(Clipboard,"[:\\]","-")
	
		; replace \\ with -
		; Clipboard := RegExReplace(Clipboard, "[\\]", "-")

	Send %Clipboard%
	return

}

