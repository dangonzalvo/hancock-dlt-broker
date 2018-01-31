.PHONY: build-dev build-prod dev test prod shell db-shell-prod docs db-dev db-shell-dev db-init-dev db-init-prod

YML_DEV=environment/dev/docker-compose.yml
YML_PROD=environment/prod/docker-compose.yml

COMPOSE_DEV=docker-compose -f ${YML_DEV}
COMPOSE_PROD=docker-compose -f ${YML_PROD}

build-dev:
	${COMPOSE_DEV} build

build-prod:
	${COMPOSE_PROD} build

dev: build-dev
	${COMPOSE_DEV} run --rm --service-ports hancock_dlt_broker dev && ${COMPOSE_DEV} down

prod: build-prod
	${COMPOSE_PROD} run --rm --service-ports hancock_dlt_broker prod && ${COMPOSE_PROD} down

test: build-dev
	${COMPOSE_DEV} run --rm --service-ports hancock_dlt_broker test && ${COMPOSE_DEV} down

shell: build-dev
	${COMPOSE_DEV} run --rm hancock_dlt_broker /bin/bash && ${COMPOSE_DEV} down

docs: build-dev
	${COMPOSE_DEV} run --rm hancock_dlt_broker /bin/bash -c "npm run docs" && ${COMPOSE_DEV} down

db-shell-dev: build-dev
	${COMPOSE_DEV} run --rm --service-ports mongo-shell && ${COMPOSE_DEV} down

db-init-dev: build-dev
	${COMPOSE_DEV} run --rm --service-ports mongo-shell /scripts/init_db.js && ${COMPOSE_DEV} down