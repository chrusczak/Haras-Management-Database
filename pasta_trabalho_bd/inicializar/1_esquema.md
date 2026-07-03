# Esquema do Banco de Dados — Sistema de Haras

## TABELA 1 — `funcionarios`

### Finalidade

Armazena os funcionários do haras responsáveis pelas atividades administrativas, manejo dos animais e vacinação.

### Principais atributos

* `cpf`: identificação única do funcionário.
* `nome`: nome completo.
* `funcao`: cargo exercido no haras.

### Regras

A função é limitada aos valores:

* VETERINARIO
* GERENTE
* TRATADOR
* ADMINISTRATIVO

---

## TABELA 2 — `fornecedor`

### Finalidade

Armazena os fornecedores responsáveis pelo fornecimento de vacinas.

### Principais atributos

* `cnpj`: identificação única do fornecedor.
* `nome`: nome da empresa.
* `telefone`: contato.
* `status`: situação atual do fornecedor.

### Regras

O fornecedor pode estar:

* ATIVO
* INATIVO

---

## TABELA 3 — `cliente`

### Finalidade

Armazena os clientes responsáveis pela compra dos animais.

### Principais atributos

* `cnpj`: identificação única do cliente.
* `nome`: nome ou razão social.
* `telefone`: contato.
* `status`: situação do cliente.

### Regras

O cliente pode estar:

* ATIVO
* INATIVO

---

## TABELA 4 — `animal`

### Finalidade

Armazena as informações dos animais pertencentes ao haras.

### Principais atributos

* `raca`
* `data_nascimento`
* `peso`
* `sexo`
* `status`

### Regras

O sexo pode ser:

* M
* F

O status pode ser:

* DISPONIVEL
* VENDIDO

---

## TABELA 5 — `vacina`

### Finalidade

Armazena as vacinas cadastradas no sistema.

### Principais atributos

* `nome`
* `obrigatoria`

### Regras

O atributo `obrigatoria` indica se a vacina é exigida para que um animal possa ser comercializado.

---

## TABELA 6 — `fornecedor_vacina`

### Finalidade

Controla os lotes de vacinas fornecidos pelos fornecedores.

### Principais atributos

* `vacina_id`
* `fornecedor_id`
* `quantidade`
* `data_vencimento`

### Relacionamentos

* Relaciona fornecedores e vacinas.
* Permite controlar estoque e validade dos lotes.

---

## TABELA 7 — `vacina_historico`

### Finalidade

Armazena o histórico de vacinação dos animais.

### Principais atributos

* `fornecedor_vacina_id`
* `animal_id`
* `funcionario_id`
* `data_vacinacao`
* `observacao`

### Relacionamentos

* Animal vacinado.
* Funcionário responsável pela aplicação.
* Lote de vacina utilizado.

---

## TABELA 8 — `venda`

### Finalidade

Armazena as vendas realizadas pelo haras.

### Principais atributos

* `animal_id`
* `cliente_id`
* `valor`
* `data_venda`

### Relacionamentos

* Cada venda está associada a um cliente.
* Cada venda está associada a um único animal.

---

## Relacionamentos Gerais

* Um fornecedor pode fornecer vários lotes de vacina.
* Uma vacina pode estar presente em vários lotes.
* Um animal pode possuir vários registros de vacinação.
* Um funcionário pode registrar várias vacinações.
* Um cliente pode realizar várias compras.
* Um animal pode ser vendido apenas uma vez.
