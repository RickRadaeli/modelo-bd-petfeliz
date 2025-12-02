# 🏥 Projeto de Modelagem de Banco de Dados: Clínica Veterinária "PetFeliz"

Este repositório contém os scripts SQL desenvolvidos para a **Experiência Prática 4**, com o objetivo de implementar o Modelo Lógico da Clínica Veterinária "PetFeliz" e demonstrar a manipulação de dados utilizando a linguagem DML (Data Manipulation Language).

---

## 📋 Pré-requisitos e Configuração

Para executar os scripts, você precisará de:

1.  Um Sistema Gerenciador de Banco de Dados (SGBD) instalado (Recomendado: **PostgreSQL** ou **MySQL**).
2.  Uma ferramenta de administração de banco de dados (ex: **PGAdmin** para PostgreSQL ou **MySQL Workbench** para MySQL).

### Instruções de Execução

1.  **Crie o Banco de Dados:** Execute o comando `CREATE DATABASE petfeliz_db;` no seu ambiente SGBD.
2.  **Criação das Tabelas (DDL):** Execute o script `01_schema_ddl.sql` para criar todas as 10 tabelas, chaves primárias e chaves estrangeiras.
3.  **Inserção de Dados (DML - INSERT):** Execute o script `02_data_insert.sql` para popular as tabelas com dados de teste (Tutores, Animais, Consultas, etc.).
4.  **Manipulação de Dados (DML - SELECT/UPDATE/DELETE):** Execute o script `03_dml_manipulation.sql` para testar as consultas, atualizações e exclusões de dados.

---

## 📁 Estrutura do Repositório

| Arquivo | Descrição | Tipo de Comando | Avaliação Obrigatória |
| :--- | :--- | :--- | :--- |
| `01_schema_ddl.sql` | Cria o banco de dados e todas as tabelas, definindo o Modelo Lógico (DDL). | DDL (Data Definition Language) | Sim |
| `02_data_insert.sql` | Insere dados de teste nas tabelas principais. **(Requisito de INSERT)** | DML (INSERT) | Sim |
| `03_dml_manipulation.sql` | Contém as consultas, atualizações e exclusões de dados. **(Requisitos de SELECT, UPDATE, DELETE)** | DML | Sim |
| `README.md` | Este arquivo, contendo instruções e documentação. | - | Sim |

---

## 🔎 DML - Requisitos Avaliados

O script `03_dml_manipulation.sql` atende aos seguintes requisitos:

| Requisito | Status | Comandos Inclusos |
| :--- | :--- | :--- |
| **Consultas (SELECT)** | ✅ Atendido (3 Consultas) | Uso de **JOIN** (em todas), **WHERE**, **ORDER BY** e **Agregação**. |
| **Atualizações (UPDATE)** | ✅ Atendido (3 Comandos) | Atualização de `status`, `peso` e `preço` com condições específicas. |
| **Exclusões (DELETE)** | ✅ Atendido (3 Comandos/Blocos) | Demonstração de `DELETE` em tabelas primárias e associativas, respeitando a Integridade Referencial. |
