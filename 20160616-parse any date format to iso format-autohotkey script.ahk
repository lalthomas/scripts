^!d::  ; ctrl+alt+d coverts the date to ansi
{
	Clipboard:= ""
	Send, ^c ;copies selected text
	ClipWait
	; Clipboard := DateParse(Clipboard)
	Clipboard := DateParseToISOStamp(Clipboard)
	Send %Clipboard%
	return
}


/*
Function: DateParse
	Converts almost any date format to a YYYYMMDDHH24MISS value.

Parameters:
	str - a date/time stamp as a string

Returns:
	A valid YYYYMMDDHH24MISS value which can be used by FormatTime, EnvAdd and other time commands.

Example:
> time := DateParse("2:35 PM, 27 November, 2007")

License:
	- Version 1.05 <http://www.autohotkey.net/~polyethene/#dateparse>
	- Dedicated to the public domain (CC0 1.0) <http://creativecommons.org/publicdomain/zero/1.0/>
*/
DateParse(str) {
	static e2 = "i)(?:(\d{1,2}+)[\s\.\-\/,]+)?(\d{1,2}|(?:Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec)\w*)[\s\.\-\/,]+(\d{2,4})"
	str := RegExReplace(str, "((?:" . SubStr(e2, 42, 47) . ")\w*)(\s*)(\d{1,2})\b", "$3$2$1", "", 1)
	If RegExMatch(str, "i)^\s*(?:(\d{4})([\s\-:\/])(\d{1,2})\2(\d{1,2}))?"
						. "(?:\s*[T\s](\d{1,2})([\s\-:\/])(\d{1,2})(?:\6(\d{1,2})\s*(?:(Z)|(\+|\-)?"
						. "(\d{1,2})\6(\d{1,2})(?:\6(\d{1,2}))?)?)?)?\s*$", i)
		d3 := i1, d2 := i3, d1 := i4, t1 := i5, t2 := i7, t3 := i8
	Else If !RegExMatch(str, "^\W*(\d{1,2}+)(\d{2})\W*$", t)
			RegExMatch(str, "i)(\d{1,2})\s*:\s*(\d{1,2})(?:\s*(\d{1,2}))?(?:\s*([ap]m))?", t)
			, RegExMatch(str, e2, d)
	f = %A_FormatFloat%
	SetFormat, Float, 02.0	
	year 	:= (d3 ? (StrLen(d3) = 2 ? 20 : "") . d3 : A_YYYY)
	month 	:= appendSeparator(((d2 := d2 + 0 ? d2 : (InStr(e2, SubStr(d2, 1, 3)) - 40) // 4 + 1.0) > 0 ? d2 + 0.0 : A_MM))
	day 	:= appendSeparator(((d1 += 0.0) ? d1 : A_DD))
	hour 	:= appendSeparator(t1 + (t1 = 12 ? t4 = "am" ? -12.0 : 0.0 : t4 = "am" ? 0.0 : 12.0)	)
	minutes := appendSeparator(t2 + 0.0)
	seconds := appendSeparator(t3 + 0.0)	
	d := year . month . day . hour . minutes . seconds
	SetFormat, Float, %f%
	Return, d
}

DateParseToISOStamp(str) {
	static e2 = "i)(?:(\d{1,2}+)[\s\.\-\/,]+)?(\d{1,2}|(?:Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec)\w*)[\s\.\-\/,]+(\d{2,4})"
	str := RegExReplace(str, "((?:" . SubStr(e2, 42, 47) . ")\w*)(\s*)(\d{1,2})\b", "$3$2$1", "", 1)
	If RegExMatch(str, "i)^\s*(?:(\d{4})([\s\-:\/])(\d{1,2})\2(\d{1,2}))?"
						. "(?:\s*[T\s](\d{1,2})([\s\-:\/])(\d{1,2})(?:\6(\d{1,2})\s*(?:(Z)|(\+|\-)?"
						. "(\d{1,2})\6(\d{1,2})(?:\6(\d{1,2}))?)?)?)?\s*$", i)
		d3 := i1, d2 := i3, d1 := i4, t1 := i5, t2 := i7, t3 := i8
	Else If !RegExMatch(str, "^\W*(\d{1,2}+)(\d{2})\W*$", t)
			RegExMatch(str, "i)(\d{1,2})\s*:\s*(\d{1,2})(?:\s*(\d{1,2}))?(?:\s*([ap]m))?", t)
			, RegExMatch(str, e2, d)
	f = %A_FormatFloat%
	SetFormat, Float, 02.0	
	year 	:= (d3 ? (StrLen(d3) = 2 ? 20 : "") . d3 : A_YYYY)
	month 	:= ((d2 := d2 + 0 ? d2 : (InStr(e2, SubStr(d2, 1, 3)) - 40) // 4 + 1.0) > 0 ? d2 + 0.0 : A_MM)
	day 	:= ((d1 += 0.0) ? d1 : A_DD)
	hour 	:= appendSeparator((t1 + (t1 = 12 ? t4 = "am" ? -12.0 : 0.0 : t4 = "am" ? 0.0 : 12.0)))
	minutes := t2 + 0.0
	seconds := t3 + 0.0
	d := year . month . day . hour . minutes . seconds
	SetFormat, Float, %f%
	Return, d
}

appendSeparator(value){
	separator := "-"
	if value >= 0
		return  separator . value
}
