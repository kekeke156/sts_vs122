ENVHASH_FILE := .envhash
ENVHASH := $(shell bash envhash.sh)
OLDHASH := $(shell cat $(ENVHASH_FILE) 2>/dev/null)
ifeq ($(ENVHASH),$(OLDHASH))
ENVDEP := 
else
ENVDEP := force-rebuild
endif

.PHONY: run
run: passwd.txt url.txt
	bash run.sh

url.txt: passwd.txt $(ENVDEP)
	bash make_url.sh
	echo "$(ENVHASH)" > "$(ENVHASH_FILE)"

passwd.txt:
	pwgen 18 1 > $@

.PHONY: force-rebuild
force-rebuild:

.PHONY: clean
clean:
	rm -f passwd.txt url.txt qr.png .envhash
