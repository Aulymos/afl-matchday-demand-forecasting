import os
from pathlib import Path

import psycopg
from dotenv import load_dotenv


PROJECT_ROOT = Path(__file__).resolve().parents[1]
load_dotenv(PROJECT_ROOT / ".env")

db_config = {
    "host": os.environ["DB_HOST"],
    "port": os.environ["DB_PORT"],
    "dbname": os.environ["DB_NAME"],
    "user": os.environ["DB_USER"],
    "password": os.environ["DB_PASSWORD"],
}

with psycopg.connect(**db_config) as connection:
    with connection.cursor() as cursor:
        cursor.execute("SELECT current_database(), current_user;")
        database_name, user_name = cursor.fetchone()

print(f"Database: {database_name}")
print(f"User: {user_name}")
print("Connection: OK")