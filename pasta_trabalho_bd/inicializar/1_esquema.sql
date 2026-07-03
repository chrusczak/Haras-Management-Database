CREATE DATABASE IF NOT EXISTS haras;
USE haras;

CREATE TABLE funcionarios (
    id INT AUTO_INCREMENT PRIMARY KEY,
    cpf CHAR(11) NOT NULL UNIQUE,
    nome VARCHAR(100) NOT NULL,
    funcao ENUM('VETERINARIO', 'GERENTE', 'TRATADOR', 'ADMINISTRATIVO') NOT NULL
);

CREATE TABLE fornecedor (
    id INT AUTO_INCREMENT PRIMARY KEY,
    cnpj CHAR(14) NOT NULL UNIQUE,
    nome VARCHAR(100) NOT NULL,
    telefone VARCHAR(20),
    status ENUM('ATIVO', 'INATIVO') DEFAULT 'ATIVO'
);

CREATE TABLE vacina (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL UNIQUE,
    obrigatoria BOOLEAN DEFAULT TRUE
);

CREATE TABLE fornecedor_vacina (
    id INT AUTO_INCREMENT PRIMARY KEY,
    vacina_id INT NOT NULL,
    fornecedor_id INT NOT NULL,
    quantidade INT NOT NULL,
    data_vencimento DATE NOT NULL,

    FOREIGN KEY (vacina_id) REFERENCES vacina(id),
    FOREIGN KEY (fornecedor_id) REFERENCES fornecedor(id)
);

CREATE TABLE cliente (
    id INT AUTO_INCREMENT PRIMARY KEY,
    cnpj CHAR(14) UNIQUE,
    nome VARCHAR(100) NOT NULL,
    telefone VARCHAR(20),
    status ENUM('ATIVO', 'INATIVO') DEFAULT 'ATIVO'
);

CREATE TABLE animal (
    id INT AUTO_INCREMENT PRIMARY KEY,
    raca VARCHAR(50) NOT NULL,
    data_nascimento DATE NOT NULL,
    peso DECIMAL(8,2) NOT NULL,
    sexo ENUM('M', 'F') NOT NULL,
    status ENUM('DISPONIVEL', 'VENDIDO') DEFAULT 'DISPONIVEL'
);

CREATE TABLE venda (
    id INT AUTO_INCREMENT PRIMARY KEY,
    animal_id INT NOT NULL UNIQUE,
    cliente_id INT NOT NULL,
    valor DECIMAL(10,2) NOT NULL,
    data_venda DATE NOT NULL,

    FOREIGN KEY (animal_id) REFERENCES animal(id),
    FOREIGN KEY (cliente_id) REFERENCES cliente(id)
);

CREATE TABLE vacina_historico (
    id INT AUTO_INCREMENT PRIMARY KEY,
    fornecedor_vacina_id INT NOT NULL,
    animal_id INT NOT NULL,
    funcionario_id INT NOT NULL,
    data_vacinacao DATE NOT NULL,
    observacao VARCHAR(255),

    FOREIGN KEY (fornecedor_vacina_id) REFERENCES fornecedor_vacina(id),
    FOREIGN KEY (animal_id) REFERENCES animal(id),
    FOREIGN KEY (funcionario_id) REFERENCES funcionarios(id)
);