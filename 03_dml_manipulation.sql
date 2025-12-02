-- #############################################
-- 03_dml_manipulation.sql: COMANDOS SELECT, UPDATE, DELETE
-- PROJETO: Clínica Veterinária PetFeliz
-- #############################################

-- =============================================
-- A. COMANDOS SELECT (CONSULTAS)
-- =============================================

-- CONSULTA 1: Listar nome do animal, nome do tutor e nome do veterinário para consultas concluídas. (JOIN, WHERE)
SELECT
    A.nome_animal,
    T.nome_tutor,
    V.nome_vet,
    C.data_hora
FROM CONSULTA C
JOIN ANIMAL A ON C.fk_animal = A.id_animal
JOIN TUTOR T ON A.fk_tutor = T.id_tutor
JOIN VETERINARIO V ON C.fk_vet = V.id_vet
WHERE C.status_consulta = 'Concluída'
ORDER BY C.data_hora DESC;


-- CONSULTA 2: Mostrar todos os animais e a data da última vacina Antirrábica. (JOIN, ORDER BY, Agregação MAX)
SELECT
    A.nome_animal,
    V.nome_vacina,
    MAX(VA.data_aplicacao) AS data_ultima_aplicacao
FROM ANIMAL A
JOIN VACINACAO VA ON A.id_animal = VA.fk_animal
JOIN VACINA V ON VA.fk_vacina = V.id_vacina
WHERE V.nome_vacina = 'Antirrábica'
GROUP BY A.nome_animal, V.nome_vacina -- Agrupa para encontrar a data MÁXIMA por animal/vacina
ORDER BY data_ultima_aplicacao DESC
LIMIT 5;

-- CONSULTA 3: Itens vendidos em consultas, com total e valor unitário. (JOIN, Cálculo)
SELECT
    IE.nome_item,
    CI.quantidade_utilizada,
    IE.preco_venda,
    (CI.quantidade_utilizada * IE.preco_venda) AS subtotal
FROM CONSULTA_ITEM CI
JOIN ITEM_ESTOQUE IE ON CI.fk_item = IE.id_item;


-- =============================================
-- B. COMANDOS UPDATE (ALTERAÇÃO DE DADOS)
-- =============================================

-- 1. UPDATE: Mudar o status da consulta agendada de Mimi (ID 3, conforme dados inseridos) para 'Cancelada'.
UPDATE CONSULTA
SET status_consulta = 'Cancelada'
WHERE id_consulta = 3;

-- 2. UPDATE: Atualizar o peso atual do animal 'Mimi' (ID 2).
UPDATE ANIMAL
SET peso_atual = 4.50
WHERE id_animal = 2;

-- 3. UPDATE: Aumentar em 10% o preço de venda da 'Ração Hipoalergênica' (ID 2).
UPDATE ITEM_ESTOQUE
SET preco_venda = preco_venda * 1.10
WHERE id_item = 2;


-- =============================================
-- C. COMANDOS DELETE (EXCLUSÃO DE DADOS)
-- =============================================

-- 1. DELETE: Excluir um item de estoque (ID 3) que foi descontinuado.
-- É necessário remover primeiro o registro na tabela associativa (CONSULTA_ITEM) devido à Chave Estrangeira.
DELETE FROM CONSULTA_ITEM
WHERE fk_item = 3;

-- Agora, remove-se o item principal do estoque.
DELETE FROM ITEM_ESTOQUE
WHERE id_item = 3;

-- 2. DELETE: Excluir a consulta de ID 4 (Vacina), que foi cancelada e não resultou em Diagnóstico.
DELETE FROM CONSULTA
WHERE id_consulta = 4;

-- 3. DELETE: Excluir a informação de um veterinário que saiu da clínica (ID 3: Dr. Pedro).
-- Antes de deletar o VETERINARIO, é preciso reatribuir suas CONSULTAS existentes para manter o histórico (Integridade Referencial).
UPDATE CONSULTA 
SET fk_vet = 1 -- Reatribui consultas antigas para o Dr. João Silva (ID 1)
WHERE fk_vet = 3;

-- Finalmente, deleta o Veterinário.
DELETE FROM VETERINARIO
WHERE id_vet = 3;
