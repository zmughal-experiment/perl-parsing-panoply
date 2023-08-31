install-deps: cpanfile maint/install-swipl-packs
	cpanm -nq --installdeps --cpanfile ./cpanfile .
	./maint/install-swipl-packs

update-cpanfile:
	scan-perl-prereqs-nqlite --save_cpanfile
