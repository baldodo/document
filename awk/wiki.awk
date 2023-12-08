BEGIN {
   today=strftime("%F",systime())
}
/^\s*$/ { print ""; next }
/^= / {
   cmd=$2
   print "=====" cmd "====="
   next
}
/^== / {
   print "===="$2" "$3" "$4" "$5" "$6"===="
   next
}
/^=== / {
   print "==="$2" "$3" "$4" "$5" "$6"==="
   next
}
/^\(#/ { print "<code>"; code=1; next }
/^#\)/ { print "</code>"; code=0; next }
/<table>/ { first=1; next}
/<\/table>/ { next}
/^\(\|/ { 
   if (!first) {
      sub("\\(|","|")
      sub("\\|\\)","|")
      gsub("\\|","|")
      gsub("\\[\\[","**")
      gsub("\\]\\]","**")
      gsub("\\(\\(","__")
      gsub("\\)\\)","__")
   } else {
      sub("\\(|","^")
      sub("\\|\\)","^")
      gsub("\\|","^")
      first=0
   }
   print
   next
}
{
   if (!code) { 
      gsub("\\[\\[","**")
      gsub("\\]\\]","**")
      gsub("\\(\\(","__")
      gsub("\\)\\)","__")
      print $0
   }
   else { 
      gsub("\\[\\[","")
      gsub("\\]\\]","")
      gsub("\\(\\(","")
      gsub("\\)\\)","")
      print $0 }
}

