# OTF Pipeline: Reverse Engineering Orange Theory Workout Data

This project reverse engineers the Orange Theory Fitness APIs to extract workout data for local, personal use.  **Your data stays local – no data is stored on any remote server**, prioritizing your privacy.

This pipeline incrementally extracts data from the Orange Theory API using dlt, transforms it with dbt within a DuckDB database, and provides a Dockerized Metabase instance for data exploration.

Interested in saving your data to another format?  Check out the [Exporting to other file types](#other-filetypes) section below.

## Key Features:

*   **Privacy-Focused:** All data processing and storage occur locally.
*   **Incremental Extraction:**  Data is pulled in stages, allowing for updates and avoiding full data downloads.
*   **dbt Transformations:**  Data is cleaned and transformed using dbt (data build tool) for consistent and reusable logic.
*   **DuckDB Database:** Leverages DuckDB for fast, in-memory data processing.
*   **Dockerized Metabase:** Provides a playground for data exploration.

## Tech Stack:

*   **dlt:**  [https://dlthub.com](https://dlthub.com) - Data Load Tool for extracting data.
*   **DuckDB:** [https://duckdb.org](https://duckdb.org) -  Embedded, in-process SQL OLAP database.
*   **dbt:** [https://www.getdbt.com](https://www.getdbt.com) - Transformation tool.
*   **Metabase:** [https://www.metabase.com](https://www.metabase.com) - Open source business intelligence tool.

## Getting Started:

1.  **Environment Setup:**

    *   Copy `.env.example` to `.env` and fill in your Orange Theory email and password:

        ```bash
        cp .env.example .env
        ```

        **Note:**  These credentials are only used locally and never stored remotely.

2.  **Data Extraction and Transformation:**

    *   Create a virtual environment (recommended):

        ```bash
        make venv
        ```

    *   Run the data extraction and transformation pipeline:

        ```bash
        python otf_pipeline.py
        ```

        This command uses `dlt` to download data and create dbt models in DuckDB.

    *   Raw data is stored in `./otf_api_data/` as delta tables.

3.  **Metabase & DuckDB Setup:**

    *   Build the DuckDB Metabase driver and Docker image:

        ```bash
        make build
        ```

    *   Start the Metabase container:
        * set initial POSTGRES_ credentials to your .env file, then run
        ```bash
        make up
        ```

        This will launch Metabase. Access it at `http://localhost:3000`. 

    *   Stop the Metabase container when finished:

        ```bash
        make down
        ```


## Status:

*   [x] Data extraction with dlt
*   [x] Transformations with dbt and DuckDB
*   [x] Dockerized DuckDB-Metabase
*   [ ] Fully configured data dashboard insights in Metabase

## <a name="other-filetypes"></a>Exporting to other file types:

using dlt as a backbone for this project enables us to easily export our data to other file types.  For example, we can comment out the `"table_format": "delta"` line in [helpers/pipeline.py](./helpers/pipeline.py) to automatically write jsonl files.

**Note**: Using delta as our default filetype allows for incremental unloading of data.  If you change the filetype, you will likely refresh ALL data on each run.
