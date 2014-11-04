tell application "TextWrangler"
  set alldocs to every text document of text window 1
  set allfiles to {}
  set str to ""
  repeat with adoc in alldocs
    if is FTP of adoc then
      set ftpinfo to FTP Info of adoc
      set murl to URL of ftpinfo
    else
      set murl to URL of adoc
    end if
    set end of allfiles to murl
    set str to str & "||" & murl
  end repeat
  set filename to (choose file name default name "TextWrangler Docs.txt")
  
  set saver to make new text document
  open saver opening in new_window
  set text of saver to "--docsaver do not edit this line" & str
  save saver to filename
  close saver
end tell

