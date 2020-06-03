# Makefile for RFC
MAKE := $(MAKE) -s

XML2RFC=xml2rfc
XML2HTML=xml2html

SOURCES= \
	*.xml

all:: banner $(SOURCES)
	@echo "  * All Done."
	@echo
	 
clean:
	@rm -f err*.txt log*.txt

distclean:
	@rm -f draft-*.{txt,html} err*.txt log*.txt

$(SOURCES):: clean
	@$(MAKE) txt
	@$(MAKE) html

txt::
	@echo ; \
	for i in $(SOURCES) ; do \
	  echo "  * Compiling: $$i [TXT]" ; \
	  out=`echo $$i | sed "s|.xml|.txt|"` ; \
	  out=`cat "$$i" | grep docName | head -n 1 | sed "s|.*docName\=\"||" | sed "s|\".*||"`; \
	  echo -E -n "    - [TXT] format ... " && \
	  $(XML2RFC) "$$i" -o "$$out.txt" \
		2>err-txt.txt >log-txt.txt && \
	  	echo "Ok." || echo "ERROR (check the err file)."; \
	done ; \
	echo

html::
	@echo ; \
	for i in $(SOURCES) ; do \
	  echo "  * Compiling: $$i [HTML]" ; \
	  out=`echo "$$i" | sed "s|.xml|.html|"` ; \
	  out=`cat "$$i" | grep docName | head -n 1 | sed "s|.*docName\=\"||" | sed "s|\".*||"`; \
	  echo -E -n "    - [HTML] format ... " && \
	  $(XML2RFC) "$$i" --html -o "$$out.html" \
		2>>err-html.txt >>log-html.txt && \
	  	echo "Ok." || echo "ERROR (check the err file)."; \
	done ; \
	echo

pdf::
	@echo ; \
	for i in $(SOURCES) ; do \
	  echo "  * Compiling: $$i [PDF]" ; \
	  out=`echo "$$i" | sed "s|.xml|.pdf|"` ; \
	  out=`cat "$$i" | grep docName | head -n 1 | sed "s|.*docName\=\"||" | sed "s|\".*||"`; \
	  echo -E -n "    - [PDF] format ... " && \
	  $(XML2RFC) "$$i" --pdf -o "$$out.pdf" \
		2>>err-html.txt >>log-html.txt && \
	  	echo "Ok." || echo "ERROR (check the err file)."; \
	done ; \
	echo

banner::
	@echo
	@echo "IETF RFC and I-D Compiler Makefile"
	@echo "(c) 2017 by Massimiliano Pala and OpenCA Labs"
	@echo "All Rights Reserved"
	@echo
