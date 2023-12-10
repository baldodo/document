
# Doc generator

Will generate html, man pages and mediawiki from the "bdoc" format which is inspired by the asciidoc format ... but different and much basic/simpler.

## Dependancies:
- awk 
- make
- sed

## Generate doc

```
make all
make save
```

## Current doc

cheatsheet about :
* bash shortcuts
* mc (midnight commander)
* terminator
* tmux

## bdoc syntax

```
title 1:     = some title
title 2:     == some secondary title
title 3:     === some tertiary title
code start:  (#
code end:    #)
table:
     <table> number_of_column
     (|column1|column2|column3|)
     (|column1|column2|column3|)
     (|column1|column2|column3|)
     </table>
```
