install-deps: cpanfile maint/install-swipl-packs
	cpanm -nq --installdeps --cpanfile ./cpanfile .
	./maint/install-swipl-packs

update-cpanfile:
	scan-perl-prereqs-nqlite --save_cpanfile

dump/%.pl.json: data/%.pl
	mkdir dump
	perl -Ilib -MO=PPP::Dump,-o,$@ $<

plot: dump/test1.pl.json
	swipl -g main lib/PPP/Prolog/rules/read-b-dump.pl $<
