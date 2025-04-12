import argparse
from dbt.cli.main import dbtRunner
from dlt import pipeline
from helpers.pipeline import otf_source

parser = argparse.ArgumentParser()
parser.add_argument("-f", "--full-refresh", help="fully refresh all data", action="store_true")
args = parser.parse_args()


def load_orange_theory(args=args) -> None:
    pipe = pipeline(
        pipeline_name="rest_api_orange_theory",
        destination="filesystem",
        dataset_name="otf_api_data",
    )

    pipe.run(otf_source(args))
    return


def run_dbt(args=args) -> None:
    dbt = dbtRunner()
    cli_args = ["run", "--project-dir", "duck_dbt", "--profiles-dir", "duck_dbt"]
    
    if args.full_refresh:
        cli_args.append("--full-refresh")

    dbt.invoke(cli_args)
    return


if __name__ == '__main__':
    load_orange_theory()
    run_dbt()
