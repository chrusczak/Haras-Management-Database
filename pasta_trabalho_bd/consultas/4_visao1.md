# Visões (Views) — Sistema de Haras

## VIEW 1 — Fornecedor × Vacina (`vw_fornecedor_vacina`)

Mostra quais fornecedores fornecem quais vacinas, incluindo a quantidade disponível e a data de vencimento do lote.

**Relevância:** Permite ao sistema identificar rapidamente de qual fornecedor cada vacina é proveniente, facilitando o controle de estoque e a rastreabilidade dos insumos utilizados no haras.

---

## VIEW 2 — Produto × Vacina (`vw_produto_vacina`)

Cruza o histórico de vacinação dos animais com informações da vacina aplicada, do funcionário responsável e do lote do fornecedor.

**Relevância:** Essencial para auditorias sanitárias, pois consolida em uma única consulta todos os dados relevantes de cada aplicação: qual vacina foi usada, quem aplicou e qual lote foi utilizado.

---

## VIEW 3 — Animal × Vacina (`vw_animal_vacina`)

Apresenta o histórico completo de vacinação de cada animal, incluindo dados do animal, da vacina, do funcionário que aplicou e do fornecedor do lote.

**Relevância:** Facilita o acompanhamento individual da saúde de cada animal, sendo útil tanto para o controle interno do haras quanto para a emissão de documentação sanitária exigida em compras e transferências.

---

## VIEW 4 — Vacinas Disponíveis (`vw_vacinas_disponiveis`)

Lista apenas os lotes de vacinas com data de vencimento igual ou posterior à data atual, ou seja, que ainda estão aptos para uso.

**Relevância:** Evita a aplicação de vacinas vencidas ao filtrar automaticamente os lotes inválidos. Garante que o estoque consultado reflita apenas insumos utilizáveis no momento da consulta.

---

## VIEW 5 — Animais Aptos para Venda (`vw_animais_aptos_venda`)

Lista os animais com status `DISPONIVEL`, idade mínima de 24 meses e pelo menos uma vacina obrigatória registrada no histórico.

**Relevância:** Automatiza a triagem de animais prontos para comercialização, considerando critérios sanitários e de maturidade. Reduz erros operacionais e agiliza o processo de seleção para venda.