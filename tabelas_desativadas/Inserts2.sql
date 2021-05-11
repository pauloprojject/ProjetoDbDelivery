select * from categoria; --ok
select * from cliente; --ok
select * from compoe; 
select * from funcionario; --ok
select * from motoboy; --ok
select * from pedido; --ok
select * from preparado; --ok
select * from produto; --ok
select * from telefone; --ok

INSERT INTO motoboy (nome) VALUES ('Jefferson')
INSERT INTO motoboy (nome) VALUES ('Cachorro_Loko')
INSERT INTO motoboy (nome) VALUES ('Moleque_du_Grau')

INSERT INTO telefone (fone, fk_cliente_codcliente, tipo) VALUES (83988887777,1,'Celular');
INSERT INTO telefone (fone, fk_cliente_codcliente, tipo) VALUES (83988887766,2,'Celular');
INSERT INTO telefone (fone, fk_cliente_codcliente, tipo) VALUES (83988887755,3,'Celular');
INSERT INTO telefone (fone, fk_cliente_codcliente, tipo) VALUES (83988887744,4,'Celular');
INSERT INTO telefone (fone, fk_cliente_codcliente, tipo) VALUES (83988887733,5,'Celular');

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



	   




