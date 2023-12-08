BEGIN {
   today=strftime("%F",systime())
}
/^\s*$/ { next }
/^= / {
   cmd=$2
   cat="\"7\""
   cmd_src="baldo/document"
   cmd_cat="cheatsheet"
   print ".TH " cmd " "cat" \""today"\" \""cmd_src"\" \""cmd_cat"\""
   next
}
/^== / {
   print ".SH "$2
   next
}
/^=== / {
   print "\n.SS"
   print $2
   next
}
/^\(#/ { print ".EX" ; code=1; next }
/^#\)/ { print ".EE" ; code=0; next }
/^\(#/ { print; next }
/<table>/ { 
   table=1
   col=$2
   if (col=="") col=3
   print ".TS"
   print "tab(|) allbox;"
   printf("l")
   col--
   for(i=0;i<col;i++) {
      printf(" l")
   } print " ."
   next }
/<\/table>/ { print ".TE"; table=0; next }
{
   if ((!code) && (!table)){
   print ".PP"
   } 
   gsub("\\[\\[","\\fB")
   gsub("\\]\\]","\\fR")
   gsub("\\(\\(","\\fI")
   gsub("\\)\\)","\\fR")
   gsub("-","\\-")
   if (table) {
      sub("\\(\\|","")
      sub("\\|\\)","")
   }
   print $0
}
END { }

