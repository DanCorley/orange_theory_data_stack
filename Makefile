ifneq (,$(wildcard ./.env))
    include .env
    export
endif

venv:
	rm -rf .venv;
	python3 -m venv .venv && \
  source .venv/bin/activate && \
  pip install -r requirements.txt -U;

build:
	docker compose build;
	cd metabase/plugins \
	  && curl -LO https://github.com/MotherDuck-Open-Source/metabase_duckdb_driver/releases/download/$(DUCK_DB_DRIVER_VERSION)/duckdb.metabase-driver.jar;

up:
	docker compose up -d --force-recreate;

logs:
	docker compose logs -f -n 10;

down:
	docker compose down -v;

run-dbt:
	dbt run --project-dir dbt --profiles-dir dbt;

dbt-metabase:
	dbt-metabase --config-path dbt/dbt_metabase_config.yml models;

lint:
	cd dbt && sqlfluff lint;

requirements:
	python3 -m venv .venv && \
  source .venv/bin/activate && \
	pip install pip-tools && \
	pip-compile requirements.in;
