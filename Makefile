setup:
	docker build . -t $$(basename "$$PWD")

test:
	docker run $$(basename "$$PWD") mix test

test-watch:
	docker run -v "$$PWD/app":/app $$(basename "$$PWD") find . | entr mix test

bash:
	docker run -v "$$PWD/app":/app -it $$(basename "$$PWD") bash

iex:
	docker run -it $$(basename "$$PWD")