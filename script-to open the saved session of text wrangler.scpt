tell application "TextWrangler"
  set filename to (choose file)
  open filename opening in new_window
  set allfilesstr to text of text document 1
  close text document 1
  set allfiles to rest of my splitit(allfilesstr, "||")
  set hasFTP to false
  
  repeat with afile in allfiles
    if afile contains "ftp" then
      set hasFTP to true
    end if
  end repeat
  set ps to ""
  if hasFTP then
    set ps to text returned of (display dialog "Type your password of the server your files are on" default answer "")
  end if
  if length of allfiles is greater than 0 then
    set afile to item 1 of allfiles
    set afile to my snr(afile, ":@", (":" & ps & "@"))
    open location afile
  end if
  set allfiles to rest of allfiles
  repeat with afile in allfiles
    set afile to my snr(afile, ":@", (":" & ps & "@"))
    open location afile
  end repeat
end tell

on snr(the_string, search_string, replace_string)
  tell (a reference to my text item delimiters)
    set {old_tid, contents} to {contents, search_string}
    set {the_string, contents} to {the_string's text items, replace_string}
    set {the_string, contents} to {the_string as Unicode text, old_tid}
  end tell
  return the_string
end snr

on splitit(the_string, search_string)
  tell (a reference to my text item delimiters)
    set {old_tid, contents} to {contents, search_string}
    set {arr, contents} to {the_string's text items, old_tid}
  end tell
  return arr
end splitit
