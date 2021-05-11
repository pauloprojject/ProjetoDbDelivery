INSERT INTO funcionario (nome, funcao, salario) VALUES 
	('Joao Jorge', 'Atendente',1200), 
	('Jorge Pimentel', 'Atendente',1200),
	('Guaraci Benito', 'Servico Gerais',1200),
	('Flaviano Braga', 'Cozinheiro',1500),
	('Rayme Carvalho', 'Gerente',3200)
	
select * from funcionario

INSERT INTO CLIENTE (nome, rg, cpf, bairro, rua, numero, ponto_de_referencia) VALUES 
	('Joao Barbosa', 12345,'12345678910', 'Mandacaru', 'Beco Ze Borges', 50, 'Bar Ze Pinguco'), 
	('Jose Franca', 12346,'12345678911', 'Cruz das Armas', 'Rua do Rio', 100, 'Padaria dos Sonhos'), 
	('Pedro Calixto', 12347,'12345678912', 'Camalau', 'Rua dos Prazeres', 2469, 'Point das Meninas'), 
	('Isaias Abraao', 12348,'12345678913', 'Roger', 'Rua dos Milagres', 33, 'Igreja da Assembleia Madureira'), 
	('Mohamed Alab', 12349,'12345678914', 'Geisel', 'Rua do Estrondo', 50, 'Central de Policia');
	
select * from cliente

INSERT INTO telefone (fone, fk_cliente_codcliente, tipo) VALUES (83988887777,1,'Celular');
INSERT INTO telefone (fone, fk_cliente_codcliente, tipo) VALUES (83988887766,2,'Celular');
INSERT INTO telefone (fone, fk_cliente_codcliente, tipo) VALUES (83988887755,3,'Celular');
INSERT INTO telefone (fone, fk_cliente_codcliente, tipo) VALUES (83988887744,4,'Celular');
INSERT INTO telefone (fone, fk_cliente_codcliente, tipo) VALUES (83988887733,5,'Celular');

select * from telefone;

INSERT INTO motoboy (nome) VALUES ('Jefferson')
INSERT INTO motoboy (nome) VALUES ('Cachorro_Loko')
INSERT INTO motoboy (nome) VALUES ('Moleque_du_Grau')

select * from motoboy;


INSERT INTO Categoria (categoria) VALUES 
	('Pizza'), 
	('Salgado'), 
	('Acai'), 
	('Sobremesas'), 
	('Sanduiche');
	
select * from categoria


INSERT INTO produto (fk_categoria_codcategoria_pk, estoque, nome) VALUES (1,5, 'Pizza Mista Pequena');
INSERT INTO produto (fk_categoria_codcategoria_pk, estoque, nome) VALUES (1,5, 'Pizza Mista Média');
INSERT INTO produto (fk_categoria_codcategoria_pk, estoque, nome) VALUES (1,5, 'Pizza Mista Grande');
INSERT INTO produto (fk_categoria_codcategoria_pk, estoque, nome) VALUES (1,5, 'Pizza Mista Familia');
INSERT INTO produto (fk_categoria_codcategoria_pk, estoque, nome) VALUES (1,5, 'Pizza Frango com Catupiry Pequena');
INSERT INTO produto (fk_categoria_codcategoria_pk, estoque, nome) VALUES (1,5, 'Pizza Frango com Catupiry Média');
INSERT INTO produto (fk_categoria_codcategoria_pk, estoque, nome) VALUES (1,5, 'Pizza Frango com Catupiry Grande');
INSERT INTO produto (fk_categoria_codcategoria_pk, estoque, nome) VALUES (1,5, 'Pizza Frango com Catupiry Familia');
INSERT INTO produto (fk_categoria_codcategoria_pk, estoque, nome) VALUES (1,5, 'Pizza Calabresa Pequena');
INSERT INTO produto (fk_categoria_codcategoria_pk, estoque, nome) VALUES (1,5, 'Pizza Calabresa Média');
INSERT INTO produto (fk_categoria_codcategoria_pk, estoque, nome) VALUES (1,5, 'Pizza Calabresa Grande');
INSERT INTO produto (fk_categoria_codcategoria_pk, estoque, nome) VALUES (1,5, 'Pizza Calabresa Familia');
INSERT INTO produto (fk_categoria_codcategoria_pk, estoque, nome) VALUES (1,5, 'Pizza Charque Pequena');
INSERT INTO produto (fk_categoria_codcategoria_pk, estoque, nome) VALUES (1,5, 'Pizza Charque Média');
INSERT INTO produto (fk_categoria_codcategoria_pk, estoque, nome) VALUES (1,5, 'Pizza Charque Grande');
INSERT INTO produto (fk_categoria_codcategoria_pk, estoque, nome) VALUES (1,5, 'Pizza Charque Familia');
INSERT INTO produto (fk_categoria_codcategoria_pk, estoque, nome) VALUES (1,5, 'Pizza A Moda Pequena');
INSERT INTO produto (fk_categoria_codcategoria_pk, estoque, nome) VALUES (1,5, 'Pizza A Moda Média');
INSERT INTO produto (fk_categoria_codcategoria_pk, estoque, nome) VALUES (1,5, 'Pizza A Moda Grande');
INSERT INTO produto (fk_categoria_codcategoria_pk, estoque, nome) VALUES (1,5, 'Pizza A Moda Familia');

INSERT INTO produto (fk_categoria_codcategoria_pk, estoque, nome) VALUES (2,5, 'Coxinha');
INSERT INTO produto (fk_categoria_codcategoria_pk, estoque, nome) VALUES (2,5, 'Enroladinho');
INSERT INTO produto (fk_categoria_codcategoria_pk, estoque, nome) VALUES (2,5, 'Empada');
INSERT INTO produto (fk_categoria_codcategoria_pk, estoque, nome) VALUES (2,5, 'Pastel de Frango');
INSERT INTO produto (fk_categoria_codcategoria_pk, estoque, nome) VALUES (2,5, 'Pastel de Carne');
INSERT INTO produto (fk_categoria_codcategoria_pk, estoque, nome) VALUES (2,5, 'Pastel Misto');

INSERT INTO produto (fk_categoria_codcategoria_pk, estoque, nome) VALUES (3,5, 'Acai no copo');
INSERT INTO produto (fk_categoria_codcategoria_pk, estoque, nome) VALUES (3,5, 'Acai Tigela P');
INSERT INTO produto (fk_categoria_codcategoria_pk, estoque, nome) VALUES (3,5, 'Acai Tigela M');
INSERT INTO produto (fk_categoria_codcategoria_pk, estoque, nome) VALUES (3,5, 'Acai Tigela G');
INSERT INTO produto (fk_categoria_codcategoria_pk, estoque, nome) VALUES (3,5, 'Barca Acai');

INSERT INTO produto (fk_categoria_codcategoria_pk, estoque, nome) VALUES (4,5, 'Torta de chocolate');
INSERT INTO produto (fk_categoria_codcategoria_pk, estoque, nome) VALUES (4,5, 'Bolo no pote');
INSERT INTO produto (fk_categoria_codcategoria_pk, estoque, nome) VALUES (4,5, 'Pudim');
INSERT INTO produto (fk_categoria_codcategoria_pk, estoque, nome) VALUES (4,5, 'Sorvete sabores');

INSERT INTO produto (fk_categoria_codcategoria_pk, estoque, nome) VALUES (5,5, 'Misto quente');
INSERT INTO produto (fk_categoria_codcategoria_pk, estoque, nome) VALUES (5,5, 'Hamburguer tradicional');
INSERT INTO produto (fk_categoria_codcategoria_pk, estoque, nome) VALUES (5,5, 'X-Frango');
INSERT INTO produto (fk_categoria_codcategoria_pk, estoque, nome) VALUES (5,5, 'X-Calabresa');
INSERT INTO produto (fk_categoria_codcategoria_pk, estoque, nome) VALUES (5,5, 'X-Egg');
INSERT INTO produto (fk_categoria_codcategoria_pk, estoque, nome) VALUES (5,5, 'X-Tudo');

update produto set preco = 20.0 where codproduto = 1;
update produto set preco = 25.0 where codproduto = 2;
update produto set preco = 35.0 where codproduto = 3;
update produto set preco = 40.0 where codproduto = 4;
update produto set preco = 20.0 where codproduto = 5;
update produto set preco = 25.0 where codproduto = 6;
update produto set preco = 35.0 where codproduto = 7;
update produto set preco = 40.0 where codproduto = 8;
update produto set preco = 20.0 where codproduto = 9;
update produto set preco = 25.0 where codproduto = 10;
update produto set preco = 35.0 where codproduto = 11;
update produto set preco = 40.0 where codproduto = 12;
update produto set preco = 20.0 where codproduto = 13;
update produto set preco = 25.0 where codproduto = 14;
update produto set preco = 35.0 where codproduto = 15;
update produto set preco = 40.0 where codproduto = 16;
update produto set preco = 20.0 where codproduto = 17;
update produto set preco = 25.0 where codproduto = 18;
update produto set preco = 35.0 where codproduto = 19;
update produto set preco = 40.0 where codproduto = 20;
update produto set preco = 3.5 where codproduto = 21;
update produto set preco = 3.5 where codproduto = 22;
update produto set preco = 3.5 where codproduto = 23;
update produto set preco = 4.0 where codproduto = 24;
update produto set preco = 3.5 where codproduto = 25;
update produto set preco = 4.5 where codproduto = 26;
update produto set preco = 3.0 where codproduto = 27;
update produto set preco = 5.0 where codproduto = 28;
update produto set preco = 10.0 where codproduto = 29;
update produto set preco = 15.0 where codproduto = 30;
update produto set preco = 30.0 where codproduto = 31;
update produto set preco = 10.0 where codproduto = 32;
update produto set preco = 5.0 where codproduto = 33;
update produto set preco = 7.0 where codproduto = 34;
update produto set preco = 7.0 where codproduto = 35;
update produto set preco = 5.0 where codproduto = 36;
update produto set preco = 5.0 where codproduto = 37;
update produto set preco = 13.0 where codproduto = 38;
update produto set preco = 12.0 where codproduto = 39;
update produto set preco = 14.0 where codproduto = 40;

INSERT INTO 
pedido (fk_cliente_codcliente, fk_motoboy_codmotoboy, fk_funcionario_codfuncionario, data, status, taxa_entrega) 
VALUES (1,1,1,current_timestamp, 'Em preparo', 10);
INSERT INTO 
pedido (fk_cliente_codcliente, fk_motoboy_codmotoboy, fk_funcionario_codfuncionario, data, status, taxa_entrega) 
VALUES (2,1,1,current_timestamp, 'Em preparo', 8.00);
INSERT INTO 
pedido (fk_cliente_codcliente, fk_motoboy_codmotoboy, fk_funcionario_codfuncionario, data, status, taxa_entrega) 
VALUES (2,2,2,current_timestamp, 'Em preparo', 8.00);
INSERT INTO 
pedido (fk_cliente_codcliente, fk_motoboy_codmotoboy, fk_funcionario_codfuncionario, data, status, taxa_entrega) 
VALUES (3,2,2,current_timestamp, 'Em preparo', 20.00);
INSERT INTO 
pedido (fk_cliente_codcliente, fk_motoboy_codmotoboy, fk_funcionario_codfuncionario, data, status, taxa_entrega) 
VALUES (5,2,1,current_timestamp, 'Em preparo', 9.00);


INSERT INTO preparado (fk_funcionario_codfuncionario, fk_pedido_codpedido) VALUES (1,1);
INSERT INTO preparado (fk_funcionario_codfuncionario, fk_pedido_codpedido) VALUES (1,2);
INSERT INTO preparado (fk_funcionario_codfuncionario, fk_pedido_codpedido) VALUES (1,3);
INSERT INTO preparado (fk_funcionario_codfuncionario, fk_pedido_codpedido) VALUES (1,4);
INSERT INTO preparado (fk_funcionario_codfuncionario, fk_pedido_codpedido) VALUES (1,5);




