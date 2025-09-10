# 🚀 SQL Avançado + Python para ETL

Este repositório documenta minha jornada prática no curso **SQL
Avançado + Python para ETL**, com foco em cenários reais de **migração
de dados** e **pipelines ETL**.

📌 Objetivos do curso:\
- Praticar SQL avançado (CTEs, window functions, otimização, validação
de dados).\
- Criar pipelines ETL em Python (pandas, sqlalchemy/psycopg2, requests,
JSON).\
- Desenvolver um mini-projeto integrador (migração de dados legado →
intermediário → API simulada).\
- Documentar cada etapa em portfólio no GitHub.

------------------------------------------------------------------------

## 📅 Estrutura do Curso

### ✅ Semana 1 -- SQL Avançado (CTEs + Window Functions)

-   Criação do banco `etl_course` com tabelas:
    -   `clientes(id, nome, email, cidade)`
    -   `pedidos(id, cliente_id, valor, data_pedido)`
-   Exercícios práticos:
    -   Clientes com mais de 2 pedidos (CTE).\
    -   Valor acumulado por cliente (CTE).\
    -   Top 3 clientes em valor acumulado.\
    -   Identificação do primeiro pedido (ROW_NUMBER).\
    -   Diferença de dias entre pedidos consecutivos (LAG).\
    -   Ranking de pedidos por valor (RANK).\
    -   Validação de duplicados e integridade referencial.

📂 Arquivos:\
- `semana1.sql` -- scripts de criação, carga e queries avançadas.

------------------------------------------------------------------------

### ✅ Semana 2 -- Python + SQL: Primeiras Extrações

-   Configuração do ambiente Python com:
    -   `pandas`, `sqlalchemy`, `psycopg2`, `jupyter`.\
-   Conexão ao PostgreSQL com `SQLAlchemy`.\
-   Extração de dados (`clientes`, `pedidos`) para DataFrames.\
-   Primeiras transformações em Pandas:
    -   Valor total por cliente.\
    -   Identificação do primeiro pedido.\
    -   Diferença em dias entre pedidos.\
-   Validação em Python:
    -   Emails duplicados.\
    -   Pedidos sem cliente válido.

📂 Arquivos:\
- `/semana2/conexao.py` -- configuração de conexão ao banco.\
- `/semana2/Semana2.ipynb` -- extração e transformações em Pandas.

------------------------------------------------------------------------

### 🔜 Semana 3 -- ETL com Arquivos Legados

-   Simulação de **dados em CSV/Excel** (legado).\
-   Extração → transformação → carga no PostgreSQL.\
-   Tratamento de inconsistências.

------------------------------------------------------------------------

### 🔜 Semana 4 -- Integração com APIs

-   Leitura de dados em JSON (via `requests`).\
-   Criação de uma API simulada (Flask ou FastAPI).\
-   Envio de dados transformados para API.

------------------------------------------------------------------------

### 🔜 Semana 5 -- Projeto Final

-   Pipeline completo:
    -   Legado → Intermediário (Postgres) → API.\
-   Documentação final e organização do portfólio.

------------------------------------------------------------------------

## 📖 Como Executar

1.  Suba o banco PostgreSQL (local ou Docker).\
2.  Execute os scripts de criação/carga em `semana1.sql`.\
3.  Configure variáveis de conexão em `conexao.py`.\
4.  Rode os notebooks semana a semana.

------------------------------------------------------------------------

## ✨ Observações

Este repositório é prático e incremental: cada semana traz exercícios
reais aplicados a cenários comuns em **engenharia de dados** e
**migração de sistemas**.
