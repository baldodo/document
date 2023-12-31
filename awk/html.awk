@include "awk/from.awk"
BEGIN {
   today=strftime("%F",systime())
   print "<!doctype html>"
   print "<html><head>"
   print "<meta charset=\"utf-8\">"
   print "<link rel=\"stylesheet\" href=\"style.css\">"
}
/^\s*$/ { if (!code) {print "<br/>"} else { print "" } next }
/^= / {
   cmd=from(2)
   print "<title>"$2"</title>"
   print "</head>"
   print "<body>"
   print "<h1>" cmd "</h1>"
   next
}
/^== / {
   print "<h2>"from(2)"</h2>"
   next
}
/^=== / {
   print "<h3>"from(2)"</h3>"
   next
}
/^\(#/ { print "<pre>"; code=1; next }
/^#\)/ { print "</pre>"; code=0; next }
/<table>/ { first=1; print $1; next}
/^\(\|/ { 
   if (!first) {
      sub("\\(\\|\\|","<tr><td class=\"code\">")
      sub("\\(\\|","<tr><td>")
      sub("\\|\\)","</td></tr>")
      gsub("\\|\\|","</td><td class=\"code\">")
      gsub("\\|","</td><td>")
         gsub("\\[\\[","<b>")
         gsub("\\]\\]","</b>")
         gsub("\\(\\(","<u>")
         gsub("\\)\\)","</u>")
   } else {
      sub("\\(\\|\\|","<tr><th class=\"code\">")
      sub("\\(\\|","<tr><th>")
      sub("\\|\\)","</th></tr>")
      gsub("\\|","</th><th>")
      first=0
   }
   print
   next
}
{
   if (!code) { print "<p>" 
      gsub("\\[\\[","<b>")
      gsub("\\]\\]","</b>")
      gsub("\\(\\(","<u>")
      gsub("\\)\\)","</u>")
      print $0
      print "</p>" 
   }
   else { 
      gsub("\\[\\[","")
      gsub("\\]\\]","")
      gsub("\\(\\(","")
      gsub("\\)\\)","")
      print $0 }
}
END {print "</body></html>" }

