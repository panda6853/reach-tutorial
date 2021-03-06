REACH = reach

.PHONY: clean
clean:
	rm -rf build/*.main.mjs

build/%.main.mjs: %.rsh
	$(REACH) compile $^ main

.PHONY: build
build: build/index.main.mjs
	docker build -f Dockerfile --tag=reachsh/reach-app-reach:latest .

.PHONY: run
run:
	$(REACH) run index

.PHONY: run-target
run-target: build
	docker-compose -f "docker-compose.yml" run --rm reach-app-reach-$${REACH_CONNECTOR_MODE} $(ARGS)

.PHONY: down
down:
	docker-compose -f "docker-compose.yml" down

.PHONY: run-live
run-live:
	docker-compose run --rm live

.PHONY: run-alice
run-alice:
	docker-compose run --rm alice

.PHONY: run-bob
run-bob:
	docker-compose run --rm bob