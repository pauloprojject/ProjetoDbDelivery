CREATE TABLE Cliente (
    CodCliente INT  PRIMARY KEY,
    Nome VARCHAR,
    RG INT,
    CPF VARCHAR,
    Bairro VARCHAR,
    Rua VARCHAR,
    Numero INT,
    Ponto_de_referencia VARCHAR,
    UNIQUE (CodCliente, RG, CPF)
);

CREATE TABLE Motoboy (
    CodMotoboy INT PRIMARY KEY,
    Nome VARCHAR
);

CREATE TABLE Produto (
    CodProduto INT PRIMARY KEY,
    fk_Categoria_CodCategoria_PK INT,
    Quantidade INT
	Nome VARCHAR(60)
);

CREATE TABLE Funcionario (
    CodFuncionario INT PRIMARY KEY,
    Nome VARCHAR,
    Funcao VARCHAR,
    Salario DECIMAL
);

CREATE TABLE Pedido (
    CodPedido INT PRIMARY KEY,
    fk_Cliente_CodCliente INT,
    fk_Motoboy_CodMotoboy INT,
    fk_Funcionario_CodFuncionario INT,
    Data TIMESTAMP,
    Staus VARCHAR,
    Valor DECIMAL,
    Taxa_Entrega DECIMAL
);

CREATE TABLE Telefone (
    Fone INT,
    fk_Cliente_CodCliente INT NOT NULL UNIQUE,
    Tipo VARCHAR,
    PRIMARY KEY (fk_Cliente_CodCliente, Fone)
);

CREATE TABLE Categoria (
    CodCategoria_PK INT NOT NULL PRIMARY KEY,
    Categoria VARCHAR
);

CREATE TABLE Gerencia (
    fk_Funcionario_CodFuncionario INT,
    fk_Funcionario_CodFuncionario_ INT,
    Valor_Total DECIMAL
);

CREATE TABLE Preparado (
    fk_Funcionario_CodFuncionario INT,
    fk_Pedido_CodPedido INT
);

CREATE TABLE Compoe (
    fk_Produto_CodProduto INT,
    fk_Pedido_CodPedido INT
);
 
ALTER TABLE Produto ADD CONSTRAINT FK_Produto_2
    FOREIGN KEY (fk_Categoria_CodCategoria_PK)
    REFERENCES Categoria (CodCategoria_PK)
    ON DELETE NO ACTION;
 
ALTER TABLE Pedido ADD CONSTRAINT FK_Pedido_2
    FOREIGN KEY (fk_Cliente_CodCliente)
    REFERENCES Cliente (CodCliente)
    ON DELETE CASCADE;
 
ALTER TABLE Pedido ADD CONSTRAINT FK_Pedido_3
    FOREIGN KEY (fk_Motoboy_CodMotoboy)
    REFERENCES Motoboy (CodMotoboy)
    ON DELETE CASCADE;
 
ALTER TABLE Pedido ADD CONSTRAINT FK_Pedido_4
    FOREIGN KEY (fk_Funcionario_CodFuncionario)
    REFERENCES Funcionario (CodFuncionario)
    ON DELETE CASCADE;

select * from telefone
 
ALTER TABLE Telefone ADD CONSTRAINT FK_Telefone_2
    FOREIGN KEY (fk_Cliente_CodCliente)
    REFERENCES Cliente (codcliente);
 
ALTER TABLE Gerencia ADD CONSTRAINT FK_Gerencia_1
    FOREIGN KEY (fk_Funcionario_CodFuncionario)
    REFERENCES Funcionario (CodFuncionario)
    ON DELETE CASCADE;
 
ALTER TABLE Gerencia ADD CONSTRAINT FK_Gerencia_2
    FOREIGN KEY (fk_Funcionario_CodFuncionario_)
    REFERENCES Funcionario (CodFuncionario)
    ON DELETE CASCADE;
 
ALTER TABLE Preparado ADD CONSTRAINT FK_Preparado_1
    FOREIGN KEY (fk_Funcionario_CodFuncionario)
    REFERENCES Funcionario (CodFuncionario)
    ON DELETE RESTRICT;
 
ALTER TABLE Preparado ADD CONSTRAINT FK_Preparado_2
    FOREIGN KEY (fk_Pedido_CodPedido)
    REFERENCES Pedido (CodPedido)
    ON DELETE SET NULL;
 
ALTER TABLE Compoe ADD CONSTRAINT FK_Compoe_1
    FOREIGN KEY (fk_Produto_CodProduto)
    REFERENCES Produto (CodProduto)
    ON DELETE RESTRICT;
 
ALTER TABLE Compoe ADD CONSTRAINT FK_Compoe_2
    FOREIGN KEY (fk_Pedido_CodPedido)
    REFERENCES Pedido (CodPedido)
    ON DELETE RESTRICT;
	
ALTER TABLE compoe
ADD COLUMN quantidade int


ALTER TABLE cliente
ADD CONSTRAINT tamanhoCPF
CHECK (length (CPF) = 11);

ALTER TABLE funcionario
ADD CONSTRAINT salariopositivo
CHECK (salario > 0);

ALTER TABLE PRODUTO
ALTER COLUMN Estoque
WHERE COLUMN = 'quantidade'

