-- #############################################
-- 01_schema_ddl.sql: CRIACAO DO BANCO DE DADOS E TABELAS (MODELO LOGICO)
-- SGBD: PostgreSQL (Ajustar para MySQL/Oracle, se necessário)
-- PROJETO: Clínica Veterinária PetFeliz
-- #############################################

-- 1. CRIAR O BANCO DE DADOS (Execute apenas uma vez no ambiente)
-- CREATE DATABASE petfeliz_db;

-- 2. TABELA TUTOR (Cliente)
CREATE TABLE TUTOR (
    id_tutor SERIAL PRIMARY KEY,
    nome_tutor VARCHAR(100) NOT NULL,
    cpf CHAR(11) UNIQUE NOT NULL,
    telefone VARCHAR(15),
    email VARCHAR(100) UNIQUE,
    endereco VARCHAR(200)
);

-- 3. TABELA VETERINARIO (Profissional)
CREATE TABLE VETERINARIO (
    id_vet SERIAL PRIMARY KEY,
    nome_vet VARCHAR(100) NOT NULL,
    crmv VARCHAR(20) UNIQUE NOT NULL,
    telefone VARCHAR(15),
    especialidade VARCHAR(50)
);

-- 4. TABELA ANIMAL (Paciente)
CREATE TABLE ANIMAL (
    id_animal SERIAL PRIMARY KEY,
    fk_tutor INTEGER NOT NULL,
    nome_animal VARCHAR(100) NOT NULL,
    especie VARCHAR(50) NOT NULL,
    raca VARCHAR(50),
    data_nasc DATE,
    peso_atual DECIMAL(5, 2), -- Ex: 99.99 kg
    
    FOREIGN KEY (fk_tutor) REFERENCES TUTOR(id_tutor)
);

-- 5. TABELA CONSULTA (Agendamento e Atendimento)
CREATE TABLE CONSULTA (
    id_consulta SERIAL PRIMARY KEY,
    fk_animal INTEGER NOT NULL,
    fk_vet INTEGER NOT NULL,
    data_hora TIMESTAMP NOT NULL,
    motivo_principal VARCHAR(255),
    status_consulta VARCHAR(20) DEFAULT 'Agendada', -- Ex: 'Agendada', 'Concluída', 'Cancelada'
    
    FOREIGN KEY (fk_animal) REFERENCES ANIMAL(id_animal),
    FOREIGN KEY (fk_vet) REFERENCES VETERINARIO(id_vet)
);

-- 6. TABELA DIAGNOSTICO (Resultado da Consulta - Relacionamento 1:1)
CREATE TABLE DIAGNOSTICO (
    id_diagnostico SERIAL PRIMARY KEY,
    fk_consulta INTEGER UNIQUE NOT NULL, -- Chave estrangeira única (1:1 com CONSULTA)
    descricao_laudo TEXT,
    tratamento_prescrito TEXT,
    
    FOREIGN KEY (fk_consulta) REFERENCES CONSULTA(id_consulta)
);

-- 7. TABELA ITEM_ESTOQUE (Produtos/Medicamentos)
CREATE TABLE ITEM_ESTOQUE (
    id_item SERIAL PRIMARY KEY,
    nome_item VARCHAR(100) NOT NULL,
    tipo VARCHAR(50) NOT NULL, -- Ex: 'Medicamento', 'Ração', 'Serviço'
    quantidade_estoque INTEGER NOT NULL,
    preco_venda DECIMAL(10, 2) NOT NULL
);

-- 8. TABELA ASSOCIATIVA: CONSULTA_ITEM (Uso de Produtos/Medicamentos em uma Consulta)
CREATE TABLE CONSULTA_ITEM (
    fk_consulta INTEGER NOT NULL,
    fk_item INTEGER NOT NULL,
    quantidade_utilizada INTEGER NOT NULL DEFAULT 1,
    
    PRIMARY KEY (fk_consulta, fk_item), -- Chave Primária Composta
    FOREIGN KEY (fk_consulta) REFERENCES CONSULTA(id_consulta),
    FOREIGN KEY (fk_item) REFERENCES ITEM_ESTOQUE(id_item)
);

-- 9. TABELA VACINA
CREATE TABLE VACINA (
    id_vacina SERIAL PRIMARY KEY,
    nome_vacina VARCHAR(100) NOT NULL,
    periodicidade_dias INTEGER -- Ex: 365 para anual
);

-- 10. TABELA ASSOCIATIVA: VACINACAO (Histórico de Vacinas do Animal)
CREATE TABLE VACINACAO (
    fk_animal INTEGER NOT NULL,
    fk_vacina INTEGER NOT NULL,
    data_aplicacao DATE NOT NULL,
    
    PRIMARY KEY (fk_animal, fk_vacina, data_aplicacao), -- Chave Composta para garantir que o animal não receba a mesma vacina no mesmo dia duas vezes
    FOREIGN KEY (fk_animal) REFERENCES ANIMAL(id_animal),
    FOREIGN KEY (fk_vacina) REFERENCES VACINA(id_vacina)
);
