# automatic help target generation

'''
.PHONY: run
\## Run Soc Compiler tool
run: 

.PHONY: help
help: Makefile
	@printf "\n###############################\n"
	@printf "# Makefile available targets:\n"
	@printf "###############################\n\n"
	@awk '/^[a-zA-Z\-\_0-9]+:/ { \
		helpMessage = match(lastLine, /^## (.*)/); \
		if (helpMessage) { \
			helpCommand = substr($$1, 0, index($$1, ":")-1); \
			helpMessage = substr(lastLine, RSTART + 3, RLENGTH); \
			printf "- %-20s %s\n", helpCommand, helpMessage; \
		} \
	} \
	{ lastLine = $$0 }' $(MAKEFILE_LIST)
	@printf "\n"

'''