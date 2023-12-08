bdoc:=$(wildcard *.bdoc)
MANPAGE:=${bdoc:.bdoc=.7}
HTML:=${bdoc:.bdoc=.html}
WIKI:=${bdoc:.bdoc=.txt}
MANDIR:=${HOME}/.local/share/man/man7

all: ${MANPAGE} ${HTML} ${WIKI}
%.bdoc:
	@sed "s/CMD/$*/" awk/template.tpl | tee $@
	@echo "$@ a été généré"
%.txt: %.bdoc
	@/usr/bin/gawk -f awk/wiki.awk "$<" > "$@"
	@echo "$@ page created"
%.7: %.bdoc
	@/usr/bin/gawk -f awk/man.awk "$<" > "$@"
	@echo "$@ page created"

%.html: %.bdoc
	@/usr/bin/gawk -f awk/html.awk "$<" > "$@"
	@echo "$@ page created"
$(MANDIR):
	@mkdir -p "$@"

upload: ${MANPAGE} $(MANDIR)
	@cp ${MANPAGE} ${MANDIR}
	@echo "${MANPAGE} uploadés"

clean:
	rm -f ${MANPAGE} ${HTML} ${WIKI}

save: ${MANPAGE} ${HTML} ${WIKI}
	@mv ${MANPAGE} man7
	@mv ${HTML} html
	@mv ${WIKI} wiki
debug:
	@echo man pages: ${MANPAGE}
	@echo html:${HTML}
	@echo man:${MANDIR}
