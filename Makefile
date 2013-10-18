BASEDIR=$(CURDIR)
HTMLDIR=$(BASEDIR)/html
DEPLOYUSER=HackingMadison
DEPLOYREPOSITORY=hackingmadison.github.io

help:
	@echo 'Makefile to push hacking madison site. Hacked down from Pelican        '
	@echo '                                                                       '
	@echo 'Usage:                                                                 '
	@echo '   make deploy                      push updates to static site        '
	@echo '                                                                       '

# borrowed from @jakevdp's pelican blog
deploy: 
	if test -d _build; \
	then echo " (_build directory exists)"; \
	else mkdir _build; \
	fi
	if test -d _build/$(DEPLOYREPOSITORY); \
	then echo "  (repository directory exists)"; \
	else cd _build && git clone git@github.com:$(DEPLOYUSER)/$(DEPLOYREPOSITORY).git; \
	fi
	cd _build/$(DEPLOYREPOSITORY) && git pull
	rsync -r $(HTMLDIR)/* _build/$(DEPLOYREPOSITORY)/
	#cd _build/$(DEPLOYREPOSITORY) && git add . && git commit -m "make deploy"
	#cd _build/$(DEPLOYREPOSITORY) && git push origin master

