-- #############################################
-- 03_dml_manipulation.sql: COMANDOS SELECT, UPDATE, DELETE
-- #############################################

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


-- CONSULTA 2: Mostrar todos os animais e a data da última vacina Antirrábica. (JOIN, ORDER BY, LIMIT)
SELECT
    A.nome_animal,
    V.nome_vacina,
    MAX(VA.data_aplicacao) AS data_ultima_aplicacao
FROM ANIMAL A
JOIN VACINACAO VA ON A.id_animal = VA.fk_animal
JOIN VACINA V ON VA.fk_vacina = V.id_vacina
WHERE V.nome_vacina = 'Antirrábica'
GROUP BY A.nome_animal, V.nome_vacina
ORDER BY data_ultima_aplicacao DESC
LIMIT 5;

-- CONSULTA 3: Itens vendidos em consultas, com total e valor unitário. (JOIN, Agregação)
SELECT
    IE.nome_item,
    CI.quantidade_utilizada,
    IE.preco_venda,
    (CI.quantidade_utilizada * IE.preco_venda) AS subtotal
FROM CONSULTA_ITEM CI
JOIN ITEM_ESTOQUE IE ON CI.fk_item = IE.id_item;
