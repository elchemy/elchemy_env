setup:
	docker build . -t $$(basename "$$PWD")

reset:
	docker build . -t $$(basename "$$PWD") --no-cache

test:
	docker run -v "$$PWD/app":/app -it $$(basename "$$PWD") mix test

test-watch:
	docker run -v "$$PWD/app":/app -it $$(basename "$$PWD") sh -c "\
		fsmonitor -s -p '+elm/*.elm' '+lib/*.ex*' '!*.elchemy.ex' mix test\
		"

bash:
	docker run -v "$$PWD/app":/app -it $$(basename "$$PWD") bash

iex:
	docker run -v "$$PWD/app":/app -it $$(basename "$$PWD")

clean:
	docker run -v "$$PWD/app":/app -it $$(basename "$$PWD") rm -rf .elchemy elm-deps