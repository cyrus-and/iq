.PHONY: doc

doc:
	R -e 'rmarkdown::render("vignettes/overview.Rmd", output_format = "md_document")'
	rm -fr doc/
	mkdir doc/
	mv vignettes/overview.md doc/
	mv vignettes/overview_files/ doc/

