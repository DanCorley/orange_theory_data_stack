# otf_pipeline
a full setup to capture and analyze orange theory workout data - dlt, deltalake, duckdb, dbt, metabase, docker


get up and running in only a few simple steps!

```shell
# after pulling REFRESH_TOKEN_AUTH from Proxyman via OTF app

# create a virtual environment to work in
> make venv

# use dlt to download all data to deltatable files + create dbt models in duckdb
> python otf_pipeline.py

# download the duckdb metabase driver and build docker image
> make build

# copy .env.example to .env and add modify database credentials
# run metabase! visit http://localhost:3000 for your instance
> make up
# and to shut it down
> make down

# modify metabase credentials in dbt/dbt_metabase_config.yml
# create primary / foreign key relationships in metabase
> make dbt-metabase
```


Wants to have:
- [] how to pull authorization with Proxyman
- [x] data extraction with dlt
- [x] transofrmations with dbt and duckdb
- [x] dockerize duckdb-metabase
- [] data dashboard insights in metabase

