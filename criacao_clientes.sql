CREATE DATABASE mapeamento;

USE mapeamento;

-- liste as entidades principais 
-- Produtos e Estoque
-- Vendas e Clientes
-- Vendedores por Unidade

-- Tabela de Unidades (As 5 novas lojas + Matriz)
CREATE TABLE unidades (
    id_unidade INT AUTO_INCREMENT PRIMARY KEY,
    nome_fantasia VARCHAR(100) NOT NULL,
    cidade VARCHAR(50),
    bairro VARCHAR(50)
);

-- Tabela de Clientes
CREATE TABLE clientes (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    cpf CHAR(11) UNIQUE NOT NULL,
    tamanho_preferencial INT,
    cor_favorita VARCHAR(30)
       
);

-- Tabela de Vendedores
CREATE TABLE vendedores (
    id_vendedor INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    id_unidade INT,
    FOREIGN KEY (id_unidade) REFERENCES unidades(id_unidade)
);

-- Tabela de Produtos (Catálogo)
CREATE TABLE produtos (
    id_produto INT AUTO_INCREMENT PRIMARY KEY,
    sku VARCHAR(50) UNIQUE NOT NULL,
    nome_modelo VARCHAR(100) NOT NULL,
    tamanho INT NOT NULL,
    cor VARCHAR(30),
    preco_venda DECIMAL(10,2) NOT NULL
);

-- Tabela de Vendas (Cabeçalho)
CREATE TABLE vendas (
    id_venda INT AUTO_INCREMENT PRIMARY KEY,
    data_hora DATETIME DEFAULT CURRENT_TIMESTAMP,
    valor_final DECIMAL(10,2),
    id_cliente INT,
    id_unidade INT,
    id_vendedor INT,
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente),
    FOREIGN KEY (id_unidade) REFERENCES unidades(id_unidade),
    FOREIGN KEY (id_vendedor) REFERENCES vendedores(id_vendedor)
);
-- Inserindo as Unidades
INSERT INTO unidades (nome_fantasia, cidade, bairro) VALUES 
('Matriz Centro', 'Brasília', 'Asa Sul'),
('Unidade 02 North', 'Brasília', 'Asa Norte'),
('Unidade 03 Shopping', 'Taguatinga', 'Centro'),
('Unidade 04 Garden', 'Guará', 'Guará II'),
('Unidade 05 Prime', 'Águas Claras', 'Sul'),
('Unidade 06 Outlet', 'Ceilândia', 'Centro');

-- Inserindo o Catálogo Inicial de Calçados
INSERT INTO produtos (sku, nome_modelo, tamanho, cor, preco_venda) VALUES 
('SAP-OXF-37-BT', 'Sapato Oxford Clássico', 37, 'Beetroot', 259.90),
('SAP-OXF-38-BT', 'Sapato Oxford Clássico', 38, 'Beetroot', 259.90),
('TEN-RUN-40-PR', 'Tênis Running Performance', 40, 'Preto', 389.00),
('TEN-RUN-41-PR', 'Tênis Running Performance', 41, 'Preto', 389.00),
('SAN-FES-36-DR', 'Sandália Festa Cristal', 36, 'Dourado', 410.00),
('SAN-FES-37-DR', 'Sandália Festa Cristal', 37, 'Dourado', 410.00),
('BOT-COU-39-CF', 'Bota Couro Casual', 39, 'Café', 320.00);


-- Faturamento total por unidade



SELECT 
    u.nome_fantasia AS unidade,
    u.cidade,
    SUM(v.valor_final) AS faturamento_total,
    COUNT(v.id_venda) AS volume_vendas
FROM vendas v
JOIN unidades u ON v.id_unidade = u.id_unidade
WHERE v.data_hora BETWEEN '2026-03-01' AND '2026-03-31'
GROUP BY u.id_unidade, u.nome_fantasia, u.cidade
ORDER BY faturamento_total DESC;

-- Versão simplificada para teste de conexão
SELECT 
    u.nome_fantasia, 
    SUM(v.valor_final) 
FROM vendas v 
JOIN unidades u ON v.id_unidade = u.id_unidade 
GROUP BY u.nome_fantasia;



