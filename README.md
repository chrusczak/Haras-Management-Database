# Haras Management Database

A MySQL-based horse farm management database designed to handle animal records, vaccination control, inventory tracking, supplier management, customer management, and sales operations.

The project implements relational database modeling, business rule enforcement through triggers, analytical views for reporting, and automated deployment using Docker.

## Academic Context

This project was developed as part of the Database Systems course in the Computer Engineering program at the Federal University of Mato Grosso (UFMT). The objective is to design and implement a relational database capable of supporting real-world business rules through SQL constraints, triggers, views, and data integrity mechanisms.

## Features

* Relational database schema
* Data integrity through foreign keys and constraints
* Business rules implemented with triggers
* Analytical views for reporting and monitoring
* Vaccination and health record management
* Supplier and inventory control
* Animal sales tracking
* Dockerized database deployment

## Technologies

* MySQL 8
* Docker
* Docker Compose
* SQL (DDL, DML, Triggers, Views)

## Project Structure

```text
.
├── docker-compose.yml
├── init/
│   └── 00_init.sh
└── pasta_trabalho_bd/
    ├── inicializar/
    ├── scripts/
    └── consultas/
```

## Setup

```bash
docker compose up -d
```

The database schema, sample data, triggers, and views are automatically created during the initialization process.

## Authors

- **DISNEY BARBOSA**
- **GABRIEL AQUINO CHRUSCZAK**
- **LUIZ MIGUEL DA SILVA SANTOS**
