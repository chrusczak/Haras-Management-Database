-- VIEW 1 — FORNECEDOR X VACINA
CREATE VIEW vw_fornecedor_vacina AS
SELECT
    f.id AS fornecedor_id,
    f.nome AS fornecedor_nome,
    f.status AS fornecedor_status,
    v.id AS vacina_id,
    v.nome AS vacina_nome,
    v.obrigatoria,
    fv.quantidade,
    fv.data_vencimento
FROM fornecedor_vacina fv
JOIN fornecedor f ON f.id = fv.fornecedor_id
JOIN vacina v ON v.id = fv.vacina_id;

-- VIEW 2 — PRODUTO X VACINA
CREATE VIEW vw_produto_vacina AS
SELECT
    a.id AS animal_id,
    a.raca,
    a.data_nascimento,
    a.peso,
    a.status AS animal_status,
    vh.data_vacinacao,
    vh.observacao,
    v.nome AS vacina_nome,
    v.obrigatoria,
    f.nome AS funcionario_nome,
    fv.data_vencimento
FROM vacina_historico vh
JOIN animal a ON a.id = vh.animal_id
JOIN funcionarios f ON f.id = vh.funcionario_id
JOIN fornecedor_vacina fv ON fv.id = vh.fornecedor_vacina_id
JOIN vacina v ON v.id = fv.vacina_id;

-- VIEW 3 — ANIMAL X VACINA
CREATE VIEW vw_animal_vacina AS
SELECT
    a.id AS animal_id,
    a.raca,
    a.data_nascimento,
    a.peso,
    a.sexo,
    a.status AS animal_status,
    v.id AS vacina_id,
    v.nome AS vacina_nome,
    v.obrigatoria,
    vh.data_vacinacao,
    vh.observacao,
    f.nome AS funcionario_nome,
    fv.quantidade,
    fv.data_vencimento,
    fo.nome AS fornecedor_nome,
    fo.status AS fornecedor_status
FROM vacina_historico vh
JOIN animal a ON a.id = vh.animal_id
JOIN funcionarios f ON f.id = vh.funcionario_id
JOIN fornecedor_vacina fv ON fv.id = vh.fornecedor_vacina_id
JOIN vacina v ON v.id = fv.vacina_id
JOIN fornecedor fo ON fo.id = fv.fornecedor_id;

-- VIEW 4 — VACINAS DISPONÍVEIS
CREATE VIEW vw_vacinas_disponiveis AS
SELECT
    v.id AS vacina_id,
    v.nome AS vacina_nome,
    v.obrigatoria,
    f.id AS fornecedor_id,
    f.nome AS fornecedor_nome,
    f.status AS fornecedor_status,
    fv.quantidade,
    fv.data_vencimento
FROM fornecedor_vacina fv
JOIN vacina v ON v.id = fv.vacina_id
JOIN fornecedor f ON f.id = fv.fornecedor_id
WHERE fv.data_vencimento >= CURDATE();


-- VIEW 5 — ANIMAIS APTOS PARA VENDA
CREATE VIEW vw_animais_aptos_venda AS
SELECT
    a.id AS animal_id,
    a.raca,
    a.data_nascimento,
    a.peso,
    a.sexo,
    a.status,
    TIMESTAMPDIFF(MONTH, a.data_nascimento, CURDATE()) AS idade_meses,
    COUNT(CASE WHEN v.obrigatoria = TRUE THEN 1 END) AS total_vacinas_obrigatorias
FROM animal a
LEFT JOIN vacina_historico vh ON vh.animal_id = a.id
LEFT JOIN fornecedor_vacina fv ON fv.id = vh.fornecedor_vacina_id
LEFT JOIN vacina v ON v.id = fv.vacina_id
WHERE a.status = 'DISPONIVEL'
GROUP BY
    a.id,
    a.raca,
    a.data_nascimento,
    a.peso,
    a.sexo,
    a.status
HAVING
    TIMESTAMPDIFF(MONTH, a.data_nascimento, CURDATE()) >= 24
    AND COUNT(CASE WHEN v.obrigatoria = TRUE THEN 1 END) > 0;
