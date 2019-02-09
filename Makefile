# Makefile for RFC

XML2RFC=xml2rfc
XML2HTML=xml2html

SOURCES= \
	*.xml

all:: banner $(SOURCES)
	@echo "  * All Done."
	@echo
	 
clean:
	@rm -f draft-*.{txt,html} err*.txt log*.txt

$(SOURCES)::
	@$(MAKE) txt
	@$(MAKE) html

txt::
	@echo ; \
	for i in $(SOURCES) ; do \
	  echo "  * Compiling: $$i [TXT]" ; \
	  out=`echo $$i | sed "s|.xml|.txt|"` ; \
	  out=`cat "$$i" | grep docName | head -n 1 | sed "s|.*docName\=\"||" | sed "s|\".*||"`; \
	  echo "    - [TXT] format ... \c" && \
	  $(XML2RFC) "$$i" -u -o "$$out.txt" \
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
	  echo "    - [HTML] format ... \c" && \
	  $(XML2RFC) "$$i" --html -u -o "$$out.html" \
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
