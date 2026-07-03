USE haras;

-- TRIGGER 1: Validação de vacinação
DROP TRIGGER IF EXISTS vacina_historico_trg;

DELIMITER $$

CREATE TRIGGER vacina_historico_trg
BEFORE INSERT ON vacina_historico
FOR EACH ROW
BEGIN
    DECLARE v_funcao VARCHAR(20);
    DECLARE v_vencimento DATE;

    -- RN01: apenas veterinários podem registrar vacinação
    SELECT funcao
    INTO v_funcao
    FROM funcionarios
    WHERE id = NEW.funcionario_id;

    IF v_funcao <> 'VETERINARIO' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Apenas veterinários podem registrar vacinação';
    END IF;

    -- RN02: vacina não pode estar vencida
    SELECT data_vencimento
    INTO v_vencimento
    FROM fornecedor_vacina
    WHERE id = NEW.fornecedor_vacina_id;

    IF v_vencimento < CURDATE() THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Vacina vencida não pode ser aplicada';
    END IF;

END$$

DELIMITER ;

-- TRIGGER 2: Validação de venda
-- (unifica as validações de cliente e de animal em uma única trigger
--  BEFORE INSERT ON venda, evitando depender da ordem de criação entre
--  duas triggers separadas no mesmo evento)
DROP TRIGGER IF EXISTS venda_trg;
DROP TRIGGER IF EXISTS cliente_venda_trg;

DELIMITER $$

CREATE TRIGGER venda_trg
BEFORE INSERT ON venda
FOR EACH ROW
BEGIN
    DECLARE v_data_nascimento DATE;
    DECLARE v_idade_meses INT;
    DECLARE v_vacinado INT;
    DECLARE v_status_animal VARCHAR(20);
    DECLARE v_status_cliente VARCHAR(20);

    -- RN08: cliente deve estar ativo
    SELECT status
    INTO v_status_cliente
    FROM cliente
    WHERE id = NEW.cliente_id;

    IF v_status_cliente <> 'ATIVO' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Cliente inativo não pode realizar compras';
    END IF;

    -- Busca dados do animal
    SELECT data_nascimento, status
    INTO v_data_nascimento, v_status_animal
    FROM animal
    WHERE id = NEW.animal_id;

    -- RN05: animal já vendido
    IF v_status_animal = 'VENDIDO' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Venda negada: animal já foi vendido';
    END IF;

    -- Calcula idade
    SET v_idade_meses = TIMESTAMPDIFF(MONTH, v_data_nascimento, NEW.data_venda);

    -- RN04: idade mínima de 24 meses
    IF v_idade_meses < 24 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Venda negada: animal não atingiu idade mínima de 24 meses';
    END IF;

    -- RN03: deve ter ao menos uma vacina obrigatória
    SELECT COUNT(*)
    INTO v_vacinado
    FROM vacina_historico vh
    JOIN fornecedor_vacina fv ON fv.id = vh.fornecedor_vacina_id
    JOIN vacina v ON v.id = fv.vacina_id
    WHERE vh.animal_id = NEW.animal_id
      AND v.obrigatoria = TRUE;

    IF v_vacinado = 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Venda negada: animal não possui vacinação obrigatória';
    END IF;

    -- Atualiza status do animal para VENDIDO
    UPDATE animal
    SET status = 'VENDIDO'
    WHERE id = NEW.animal_id;

END$$

DELIMITER ;

-- TRIGGER 3: Validação de fornecedor ao registrar vacina
DROP TRIGGER IF EXISTS fornecedor_vacina_trg;

DELIMITER $$

CREATE TRIGGER fornecedor_vacina_trg
BEFORE INSERT ON fornecedor_vacina
FOR EACH ROW
BEGIN
    DECLARE v_status VARCHAR(20);

    -- Fornecedor deve estar ativo
    SELECT status
    INTO v_status
    FROM fornecedor
    WHERE id = NEW.fornecedor_id;

    IF v_status <> 'ATIVO' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Fornecedor inativo não pode fornecer vacinas';
    END IF;

    -- Quantidade deve ser positiva
    IF NEW.quantidade <= 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Quantidade inválida';
    END IF;

END$$

DELIMITER ;