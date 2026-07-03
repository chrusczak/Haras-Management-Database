USE haras;

-- ============================================================
-- SETUP: animais de teste (101 jovem demais, 102 sem vacina, 103 apto)
-- ============================================================
INSERT INTO animal (raca, data_nascimento, peso, sexo, status) VALUES
('Nelore', '2025-06-01', 350.00, 'M', 'DISPONIVEL'),
('Angus', '2020-01-01', 500.00, 'F', 'DISPONIVEL'),
('Brahman', '2020-05-05', 600.00, 'M', 'DISPONIVEL');

-- Vacina obrigatória no animal 103, para ele estar apto à venda
INSERT INTO vacina_historico (fornecedor_vacina_id, animal_id, funcionario_id, data_vacinacao, observacao)
VALUES (1, 103, 1, '2024-01-01', 'Vacinação de teste');

-- ============================================================
-- DEMONSTRAÇÃO DO TRIGGER: venda_trg
-- ============================================================

-- ANTES: status do animal 103 (Brahman, nascido em 2020-05-05)
SELECT id, raca, data_nascimento, status
FROM animal
WHERE id = 103;

-- Tentativa de venda inválida: cliente inativo (id=91)
-- Esperado: erro 'Cliente inativo não pode realizar compras'
INSERT INTO venda (animal_id, cliente_id, valor, data_venda)
VALUES (103, 91, 5000.00, '2026-06-28');

-- Tentativa de venda inválida: animal muito novo (id=101, nascido em 2025-06-01)
-- Esperado: erro 'Venda negada: animal não atingiu idade mínima de 24 meses'
INSERT INTO venda (animal_id, cliente_id, valor, data_venda)
VALUES (101, 1, 3000.00, '2026-06-28');

-- Tentativa de venda inválida: animal sem vacina obrigatória (id=102)
-- Esperado: erro 'Venda negada: animal não possui vacinação obrigatória'
INSERT INTO venda (animal_id, cliente_id, valor, data_venda)
VALUES (102, 1, 4000.00, '2026-06-28');

-- ============================================================
-- VENDA VÁLIDA
-- ============================================================

-- ANTES
SELECT id, raca, data_nascimento, status FROM animal WHERE id = 103;

-- Venda válida: animal 103 (Brahman, nascido 2020-05-05, tem vacina obrigatória, cliente ativo)
INSERT INTO venda (animal_id, cliente_id, valor, data_venda)
VALUES (103, 1, 5200.00, '2026-06-28');

-- DEPOIS: status deve ter mudado para VENDIDO
SELECT id, raca, data_nascimento, status FROM animal WHERE id = 103;

-- ============================================================
-- DEMONSTRAÇÃO DO TRIGGER: vacina_historico_trg
-- ============================================================

-- Tentativa com funcionário não veterinário (id=4, Roberto Lima - GERENTE)
-- Esperado: erro 'Apenas veterinários podem registrar vacinação'
INSERT INTO vacina_historico (fornecedor_vacina_id, animal_id, funcionario_id, data_vacinacao, observacao)
VALUES (1, 103, 4, '2026-06-28', 'Teste com gerente');