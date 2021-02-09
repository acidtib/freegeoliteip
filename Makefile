# === Sam shortcut
# next lines are autogenerated and any changes will be discarded after regenerating
CRYSTAL_BIN ?= `which crystal`
SAM_PATH ?= "src/sam.cr"
.PHONY: sam
sam:
	$(CRYSTAL_BIN) $(SAM_PATH) $(filter-out $@,$(MAKECMDGOALS))
%:
	@:
# === Sam shortcut

run:
	$(CRYSTAL_BIN) run ./src/application.cr -D logs

docker.run:
	docker-compose up --build

docker.build:
	docker build -f Dockerfile.dev -t arubinofaux/freegeoliteip_services:latest .


db.create:
	docker-compose run web make sam db:create

db.migrate:
	docker-compose run web make sam db:migrate