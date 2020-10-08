from airflow import DAG 
from airflow.operators.bash_operator import BashOperator
from airflow.operators.python_operator import PythonOperator
from datetime import datetime, timedelta
import time
from airflow.hooks.base_hook import BaseHook

args = {
    'owner': 'airflow',
    'start_date': datetime(2019, 12, 10)
}

##comments
with DAG(
    dag_id='example_bash2',
    default_args=args,
    schedule_interval=None
) as dag:

    start_task = BashOperator(
        task_id="start_task",
        bash_command='date && env && echo "started dags"'
    )

    sec_task = BashOperator (
        task_id="sec_task",
        bash_command='env && echo "completed dags"'
    )
   

start_task >> sec_task
