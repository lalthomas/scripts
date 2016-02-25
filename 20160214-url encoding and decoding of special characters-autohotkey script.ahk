; thank you https://autohotkey.com/board/topic/17367-url-encoding-and-decoding-of-special-characters/
; shift+control+t
+^t::
	AutoTrim, Off
	url_temp_clip = %clipboard%
	Send, ^c
	IfInString, clipboard, `%
	{
		clipboard := uriDecode(clipboard)
	}
	else
	{
		clipboard := uriEncode(clipboard)
	}
	Send, ^v
	clipboard = %url_temp_clip%
	AutoTrim, On
return

uriDecode(str)
{
	; Find uri encoded characters such as %20 (space) and replace with ascii character

	pos = 1
	Loop
		If pos := RegExMatch(str, "i)(?<=%)[\da-f]{2}", hex, pos++)
			StringReplace, str, str, `%%hex%, % Chr("0x" . hex), All
		Else Break
	Return, str
}

uriEncode(str)
{
	; Replace characters with uri encoded version except for letters, numbers,
	; and the following: /.~:&=-

	f = %A_FormatInteger%
	SetFormat, Integer, Hex
	pos = 1
	Loop
		If pos := RegExMatch(str, "i)[^\/\w\.~`:%&=-]", char, pos++)
			StringReplace, str, str, %char%, % "%" . Asc(char), All
		Else Break
	SetFormat, Integer, %f%
	StringReplace, str, str, 0x, , All
	Return, str
}