source = pbpk-absorption-models.ipe
zip = pbpk-absorption-models.zip

views = $(shell echo view-1-{$(shell seq -s, 1 8)} view-2-{$(shell seq -s, 1 16)})

pdf          = $(views:%=pdf/%.pdf)
svg          = $(views:%=svg/%.svg)
emf_inkscape = $(views:%=emf/inkscape/%.emf)
emf_convert  = $(views:%=emf/convert/%.emf)

all: $(pdf) $(svg) $(emf_inkscape) $(emf_convert)

pdf/view-%.pdf: $(source)
	mkdir -p pdf
	ipetoipe -pdf -export -view $* $< $@

svg/view-%.svg: $(source)
	mkdir -p svg
	$(eval page := $(shell sed 's/-[0-9]*//' <<< $*))
	$(eval view := $(shell sed 's/[0-9]*-//' <<< $*))
	iperender -svg -page $(page) -view $(view) $< $@

emf/inkscape/%.emf: svg/%.svg
	mkdir -p emf/inkscape
	inkscape --file $< --export-emf $@

emf/convert/%.emf: svg/%.svg
	mkdir -p emf/convert
	convert $< $@

zip: $(zip)

$(zip): all
	zip -r $@ \
		pdf \
		svg \
		emf

clean:
	rm -rf pdf svg emf $(zip)
