from sqlalchemy import create_engine
import os
from dotenv import load_dotenv

load_dotenv()

# ajuste conforme sua senha/porta
USER = os.getenv("POSTGRES_USER")
PASSWORD = os.getenv("POSTGRES_PASSWORD")
HOST = os.getenv("POSTGRES_SERVER")
PORT = os.getenv("POSTGRES_PORT")
DB = os.getenv("POSTGRES_DB")

def get_engine():
    string_conn = f"postgresql+psycopg2://{USER}:{PASSWORD}@{HOST}:{PORT}/{DB}"
    engine = create_engine(string_conn)
    return engine