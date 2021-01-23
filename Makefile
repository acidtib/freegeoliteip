CRYSTAL_BIN ?= `which crystal`

run:
	$(CRYSTAL_BIN) run ./src/application.cr -D logs

docker.run:
	docker-compose up

docker.build:
	docker build -f Dockerfile.dev -t arubinofaux/freegeoliteip_services:latest .