figures = $(shell echo view-1-{$(shell seq -s, 1 8)}.pdf view-2-{$(shell seq -s, 1 16)}.pdf)
source = pbpk-absorption-models.ipe

all: $(figures)

view-%.pdf: $(source)
	ipetoipe -pdf -export -view $* $< $@
