create database criacao_clientes

use criacao_cleintes

create database criacao_clientes;

CREATE TABLE clientes (
    id_vendedor INT PRIMARY KEY,
    nome_vendedor VARCHAR(100),
    equipe VARCHAR(100)
);



ALTER TABLE clientes 
ADD COLUMN data_cadastro DATE AFTER equipe; 
-- O 'AFTER' é opcional, serve para posicionar a coluna onde você quiser
