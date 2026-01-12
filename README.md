# OTF Pipeline
A reverse engineering project to extract orange theory workout data for local personal use. **No data is stored on any remote server** keeping to a privacy first approach.

Includes pipeline to incrementally extract data from the orange theory API and transform with dbt in a duckdb database. Finally, a dockerized metabase instance paired with duckdb driver is included to allow for data exploration.

## Tech Stack:
- dlt : https://dlthub.com
- duckdb : https://duckdb.org
- dbt : https://www.getdbt.com
- metabase : https://www.metabase.com
- docker : https://www.docker.com

## Getting Started:

copy .env.example to .env and modify `ORANGE_THEORY_EMAIL` and `ORANGE_THEORY_PASSWORD` to those used to login to the Orange Theory App. *These credentials never leave your local machine.*

```shell
# create a virtual environment to work in
> make venv

# use dlt to download all data to deltatable files + create dbt models in duckdb
> python otf_pipeline.py

# download the duckdb metabase driver and build docker image
> make build

# copy .env.example to .env and create secrets database credentials
# run metabase! visit http://localhost:3000 for your instance
> make up
# and to shut it down
> make down

# modify metabase credentials in dbt/dbt_metabase_config.yml
# create primary / foreign key relationships in metabase
> make dbt-metabase
```


Wants to have:
- [x] data extraction with dlt
- [x] transofrmations with dbt and duckdb
- [x] dockerize duckdb-metabase
- [] data dashboard insights in metabase

