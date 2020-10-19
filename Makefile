# Makefile for easy building and clean up.

# For more info, see
# https://tex.stackexchange.com/questions/7770/file-extensions-related-to-latex-etc
# https://tex.stackexchange.com/questions/11123/prevent-pdflatex-from-writing-a-bunch-of-files

OUTPUT_DIR=_build
FILE=main

build: ## Build pdf
	sh build_tools/build.sh $(OUTPUT_DIR) $(FILE)

clean: ## Clean build files
	rm -rf $(OUTPUT_DIR)/*
	rm -f $(FILE).pdf
