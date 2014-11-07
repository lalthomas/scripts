; Thanks : http://robertmarkbramprogrammer.blogspot.in/2011/02/insert-date-into-any-program-using.html
; - Insert Date Time stamp


#.:: ;; Windows key + dot:

   FormatTime, xx,,yyyyMMdd
   SendInput, %xx%

return

+#.:: ;;Windows key + shift + dot:

   FormatTime, xx,,yyyy-MM-dd
   SendInput, %xx%

return