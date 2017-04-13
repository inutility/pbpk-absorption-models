figures = $(shell echo view-{1,2,3,4,5,6,7,8}.pdf)
source = pbpk-absorption-models.ipe

all: $(figures)

view-%.pdf: $(source)
	ipetoipe -pdf -export -view 1-$* $< $@
