import pandas as pd
from conexao import get_engine


engine = get_engine()

# ====================================================
# ETAPA 1: EXTRAÇÃO
# ====================================================
def extract_clientes(file_path: str) -> pd.DataFrame:
    df = pd.read_csv(file_path)
    print(f"[EXTRACT] Clientes extraídos: {len(df)} registros")
    return df


def extract_pedidos(file_path: str) -> pd.DataFrame:
    df = pd.read_csv(file_path)
    print(f"[EXTRACT] Pedidos extraídos: {len(df)} registros")
    return df


# ====================================================
# ETAPA 2: TRANSFORMAÇÃO
# ====================================================
def transform_clientes(df: pd.DataFrame) -> pd.DataFrame:
    df = df.rename(columns={
        "id_cliente": "id",
        "nome_completo": "nome"
    })
    # Validar duplicados em email
    duplicados = df[df["email"].duplicated()]
    if not duplicados.empty:
        print(f"[WARN] Clientes com email duplicado:\n{duplicados}")
    print(f"[TRANSFORM] Clientes transformados: {len(df)} registros")
    return df


def transform_pedidos(df: pd.DataFrame, clientes: pd.DataFrame) -> pd.DataFrame:
    df = df.rename(columns={
        "id_pedido": "id",
        "cliente_ref": "cliente_id",
        "valor_total": "valor",
        "data_compra": "data_pedido"
    })
    # Converter data
    df["data_pedido"] = pd.to_datetime(df["data_pedido"], errors="coerce")

    # Validar integridade (pedidos sem cliente válido)
    pedidos_invalidos = df[~df["cliente_id"].isin(clientes["id"])]
    if not pedidos_invalidos.empty:
        print(f"[WARN] Pedidos inválidos encontrados:\n{pedidos_invalidos}")

    print(f"[TRANSFORM] Pedidos transformados: {len(df)} registros")
    return df


# ====================================================
# ETAPA 3: CARGA
# ====================================================
def load_to_postgres(df: pd.DataFrame, table_name: str):
    df.to_sql(table_name, engine, schema="etl_course", if_exists="replace", index=False)
    print(f"[LOAD] {len(df)} registros carregados em etl_course.{table_name}")


# ====================================================
# PIPELINE PRINCIPAL
# ====================================================
def etl_pipeline():
    # Extração
    clientes_raw = extract_clientes("dataset_semana3/clientes_legado.csv")
    pedidos_raw = extract_pedidos("dataset_semana3/pedidos_legado.csv")

    # Transformação
    clientes = transform_clientes(clientes_raw)
    pedidos = transform_pedidos(pedidos_raw, clientes)

    # Carga
    load_to_postgres(clientes, "clientes")
    load_to_postgres(pedidos, "pedidos")

    print("[DONE] Pipeline ETL concluído com sucesso.")


if __name__ == "__main__":
    etl_pipeline()