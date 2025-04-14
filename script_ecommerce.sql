CREATE TABLE Clientes (
    idCliente INT PRIMARY KEY,
    nome VARCHAR(100),
    endereco VARCHAR(150)
);

CREATE TABLE ClientesPF (
    idClientePF INT PRIMARY KEY,
    idCliente INT UNIQUE,
    cpf VARCHAR(14),
    FOREIGN KEY (idCliente) REFERENCES Clientes(idCliente)
);

CREATE TABLE ClientesPJ (
    idClientePJ INT PRIMARY KEY,
    idCliente INT UNIQUE,
    cnpj VARCHAR(18),
    razaoSocial VARCHAR(100),
    FOREIGN KEY (idCliente) REFERENCES Clientes(idCliente)
);

CREATE TABLE Pedido (
    idPedido INT PRIMARY KEY,
    idCliente INT,
    statusPedido VARCHAR(45),
    descricao VARCHAR(255),
    frete FLOAT,
    codigoRastreio VARCHAR(45),
    dataLimiteDevolucao VARCHAR(45),
    FOREIGN KEY (idCliente) REFERENCES Clientes(idCliente)
);

CREATE TABLE Produto (
    idProduto INT PRIMARY KEY,
    categoria VARCHAR(45),
    descricao VARCHAR(45),
    valor VARCHAR(45)
);

CREATE TABLE Fornecedor (
    idFornecedor INT PRIMARY KEY,
    razaoSocial VARCHAR(45),
    cnpj VARCHAR(45)
);

CREATE TABLE Estoque (
    idEstoque INT PRIMARY KEY,
    local VARCHAR(45)
);

CREATE TABLE Produto_has_Estoque (
    idProduto INT,
    idEstoque INT,
    quantidade INT,
    PRIMARY KEY (idProduto, idEstoque),
    FOREIGN KEY (idProduto) REFERENCES Produto(idProduto),
    FOREIGN KEY (idEstoque) REFERENCES Estoque(idEstoque)
);

CREATE TABLE ThirdParty_Seller (
    idTerceiro INT PRIMARY KEY,
    razaoSocial VARCHAR(45),
    local VARCHAR(45)
);

CREATE TABLE ThirdParty_Produtos (
    idTerceiro INT,
    idProduto INT,
    quantidade INT,
    PRIMARY KEY (idTerceiro, idProduto),
    FOREIGN KEY (idTerceiro) REFERENCES ThirdParty_Seller(idTerceiro),
    FOREIGN KEY (idProduto) REFERENCES Produto(idProduto)
);

CREATE TABLE Disponibilidade_do_Produto (
    idFornecedor INT,
    idProduto INT,
    PRIMARY KEY (idFornecedor, idProduto),
    FOREIGN KEY (idFornecedor) REFERENCES Fornecedor(idFornecedor),
    FOREIGN KEY (idProduto) REFERENCES Produto(idProduto)
);

CREATE TABLE Pagamento (
    idPagamento INT PRIMARY KEY,
    idPedido INT,
    tipoPagamento VARCHAR(45),
    statusPagamento VARCHAR(45),
    FOREIGN KEY (idPedido) REFERENCES Pedido(idPedido)
);

CREATE TABLE Entrega (
    idEntrega INT PRIMARY KEY,
    idPedido INT,
    statusEntrega VARCHAR(45),
    codigoRastreio VARCHAR(45),
    FOREIGN KEY (idPedido) REFERENCES Pedido(idPedido)
);

CREATE TABLE Vendedor (
    customer_id INT PRIMARY KEY,
    customer_name CHAR(50) NOT NULL
);

CREATE TABLE Relacao_Produto_Pedido (
    idProduto INT,
    idPedido INT,
    quantidade INT,
    PRIMARY KEY (idProduto, idPedido),
    FOREIGN KEY (idProduto) REFERENCES Produto(idProduto),
    FOREIGN KEY (idPedido) REFERENCES Pedido(idPedido)
);

-- Consultas SQL

-- 1. Quantidade de pedidos por cliente
SELECT c.nome, COUNT(p.idPedido) AS total_pedidos
FROM Clientes c
JOIN Pedido p ON c.idCliente = p.idCliente
GROUP BY c.nome;

-- 2. Vendedores que também são fornecedores
SELECT v.customer_name AS vendedor, f.razaoSocial AS fornecedor
FROM Vendedor v
JOIN Fornecedor f ON v.customer_name = f.razaoSocial;

-- 3. Produtos, fornecedores e estoques
SELECT p.descricao AS produto, f.razaoSocial AS fornecedor, e.quantidade
FROM Produto p
JOIN Disponibilidade_do_Produto dp ON p.idProduto = dp.idProduto
JOIN Fornecedor f ON dp.idFornecedor = f.idFornecedor
JOIN Produto_has_Estoque e ON p.idProduto = e.idProduto;

-- 4. Relação de nomes dos fornecedores e nomes dos produtos
SELECT f.razaoSocial, p.descricao
FROM Fornecedor f
JOIN Disponibilidade_do_Produto dp ON f.idFornecedor = dp.idFornecedor
JOIN Produto p ON dp.idProduto = p.idProduto;

-- 5. Clientes PJ com mais de um pedido
SELECT pj.cnpj, COUNT(p.idPedido) AS pedidos
FROM Clientes c
JOIN ClientesPJ pj ON c.idCliente = pj.idCliente
JOIN Pedido p ON p.idCliente = c.idCliente
GROUP BY pj.cnpj
HAVING COUNT(p.idPedido) > 1;
