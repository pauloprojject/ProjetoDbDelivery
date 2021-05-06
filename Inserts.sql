INSERT INTO CLIENTE (nome, rg, cpf, bairro, rua, numero, ponto_de_referencia) VALUES 
	('Joao Barbosa', 12345,'12345678910', 'Mandacaru', 'Beco Ze Borges', 50, 'Bar Ze Pinguco'), 
	('Jose Franca', 12346,'12345678911', 'Cruz das Armas', 'Rua do Rio', 100, 'Padaria dos Sonhos'), 
	('Pedro Calixto', 12347,'12345678912', 'Camalau', 'Rua dos Prazeres', 2469, 'Point das Meninas'), 
	('Isaias Abraao', 12348,'12345678913', 'Roger', 'Rua dos Milagres', 33, 'Igreja da Assembleia Madureira'), 
	('Mohamed Alab', 12349,'12345678914', 'Geisel', 'Rua do Estrondo', 50, 'Central de Policia');
	
select * from cliente

INSERT INTO Categoria (categoria) VALUES 
	('Pizza'), 
	('Salgado'), 
	('Acai'), 
	('Sobremesas'), 
	('Sanduiche');
	
select * from categoria

INSERT INTO funcionario (nome, funcao, salario) VALUES 
	('Joao Jorge', 'Atendente',1200), 
	('Jorge Pimentel', 'Atendente',1200),
	('Guaraci Benito', 'Servico Gerais',1200),
	('Flaviano Braga', 'Cozinheiro',1500),
	('Rayme Carvalho', 'Gerente',3200)
	
select * from funcionario

