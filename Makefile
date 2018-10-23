run = docker run -v "$$PWD/app":/app -it $$(basename "$$PWD") $(1)

setup:
	docker build  . -t $$(basename "$$PWD")

reset:
	docker build . -t $$(basename "$$PWD") --no-cache

test:
	$(call run,mix test)

test-watch:
	$(call run,sh -c "\
		fsmonitor -s -p '+elm/*.elm' '+lib/*.ex*' '!*.elchemy.ex' mix test\
		")

bash:
	$(call run,bash)

iex:
	$(call run)

clean:
	$(call run,rm -rf .elchemy elm-deps)