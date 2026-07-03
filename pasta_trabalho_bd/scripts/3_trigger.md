# Triggers — Sistema de Haras

## TRIGGER 1 — `vacina_historico_trg`

**Evento:** BEFORE INSERT em `vacina_historico`

### Regras de negócio

**RN01 — Somente veterinários podem registrar vacinação**
Apenas funcionários com função `VETERINARIO` têm autorização para aplicar e registrar vacinas. Registros feitos por tratadores, gerentes ou administrativos são bloqueados, garantindo que a vacinação seja realizada por profissional habilitado.

**RN02 — Vacina vencida não pode ser aplicada**
O sistema verifica a `data_vencimento` do lote (`fornecedor_vacina`) antes de registrar a aplicação. Se o lote estiver vencido, a operação é cancelada, protegendo a saúde dos animais e a conformidade sanitária.

---

## TRIGGER 2 — `venda_trg`

**Evento:** BEFORE INSERT em `venda`

### Regras de negócio

**RN03 — Animal deve ter ao menos uma vacina obrigatória**
Animais sem nenhuma vacina marcada como `obrigatoria = TRUE` no histórico não podem ser comercializados. Isso garante conformidade com exigências sanitárias para transporte e venda de bovinos.

**RN04 — Idade mínima de 24 meses**
Animais com menos de 24 meses de vida não estão aptos para venda. A idade é calculada dinamicamente com base na `data_nascimento` e na `data_venda`.

**RN05 — Animal já vendido não pode ser vendido novamente**
O trigger verifica o `status` do animal antes da venda. Se já estiver como `VENDIDO`, a operação é bloqueada. Após uma venda bem-sucedida, o status é atualizado automaticamente para `VENDIDO`.

---

## TRIGGER 3 — `fornecedor_vacina_trg`

**Evento:** BEFORE INSERT em `fornecedor_vacina`

### Regras de negócio

**RN06 — Fornecedor deve estar ativo**
Somente fornecedores com status `ATIVO` podem ter lotes de vacinas registrados no sistema.

**RN07 — Quantidade deve ser positiva**
O campo `quantidade` deve ser maior que zero para garantir integridade dos dados de estoque.

---

## TRIGGER 4 — `cliente_venda_trg`

**Evento:** BEFORE INSERT em `venda`

### Regras de negócio

**RN08 — Cliente deve estar ativo**
Clientes com status `INATIVO` não podem realizar compras. Isso permite suspender clientes inadimplentes ou com pendências sem excluí-los do sistema.