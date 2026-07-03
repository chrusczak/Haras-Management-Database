#!/bin/bash
set -e

MYSQL="mysql -uroot -p${MYSQL_ROOT_PASSWORD} haras"

echo "Rodando esquema..."
$MYSQL < /work/inicializar/1_esquema.sql


echo "Populando o banco..."
$MYSQL < /work/scripts/2_popular.sql

echo "Rodando triggers..."
$MYSQL < /work/scripts/3_trigger.sql


echo "Criando views..."
$MYSQL < /work/consultas/4_visao1.sql

echo "Init concluído."