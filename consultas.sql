-- b) ii 01 consulta usando between
SELECT * 
FROM funcionario 
WHERE salario between 1000 AND 2000

-- b) ii 03 consultas usando JOIN
--Selecione o nome do motoboy e o código do pedido que ele fez a entrega
SELECT p.codpedido, m.nome
FROM pedido p INNER JOIN motoboy m
ON p.fk_motoboy_codmotoboy = m.codmotoboy

--Selecione o nome do funcionario e o código do pedido que ele atendeu
SELECT p.codpedido, f.nome
FROM pedido p INNER JOIN funcionario f
ON p.fk_funcionario_codfuncionario = f.codfuncionario

--Selecione todos os produtos da categoria Pizza
SELECT p.nome
FROM produto p INNER JOIN categoria c
ON p.fk_categoria_codcategoria_pk = c.codcategoria_pk
WHERE c.categoria = 'Pizza'

-- 01 consulta com LEFT/right/full outer JOIN na cláusula FROM
--Selecione os clientes que ainda não tem pedido
SELECT c.codcliente, c.nome, p.codpedido
FROM cliente c LEFT JOIN pedido p
ON c.codcliente = p.fk_cliente_codcliente
WHERE codpedido IS NULL

-- 02 consultas usando GROUP BY
-- Consulte quantos produtos estão cadastrado por categoria
SELECT  c.categoria AS nome_categoria, count(p.fk_categoria_codcategoria_pk)
FROM produto p JOIN categoria c
ON p.fk_categoria_codcategoria_pk = c.codcategoria_pk
GROUP BY nome_categoria

-- Quantos produtos tem estoque maior que 30 unidades na categoria bebidas
SELECT p.estoque, p.nome
FROM produto p JOIN categoria c
ON p.fk_categoria_codcategoria_pk = c.codcategoria_pk
GROUP BY p.estoque, p.nome, c.categoria
HAVING p.estoque > 30 AND c.categoria = 'Bebidas'


-- consulta usando alguma operação de conjunto (UNION, except ou intersect)
-- Selecione todos os nomes e papeis de possiveis envolvidos na formação de um pedido
SELECT nome, 'Funcionario' AS Identidade
FROM funcionario

UNION

SELECT nome, 'Cliente'
FROM cliente

UNION

SELECT nome, 'Motoboy'
FROM motoboy
ORDER BY Identidade

-- 02 consultas que usem subqueries.
-- Retorne uma consulta usando subquery dos pedidos que o motoboy 'Cachorro_Loko' entregou	
SELECT p.codpedido, p.fk_motoboy_codmotoboy, (SELECT m.nome FROM motoboy m WHERE m.nome = 'Cachorro_Loko')
    FROM pedido p
	WHERE p.fk_motoboy_codmotoboy IN (SELECT m.codmotoboy
									 FROM motoboy m JOIN pedido p
									 ON p.fk_motoboy_codmotoboy = m.codmotoboy
									 WHERE m.nome = 'Cachorro_Loko')	
									 

-- Retorne os dados de todos os clientes que já fizeram pedidos 
SELECT codcliente, nome, rua, bairro, numero 
FROM cliente 
WHERE codcliente IN (SELECT fk_cliente_codcliente 
					 FROM pedido 
					 WHERE cliente.codcliente = pedido.fk_cliente_codcliente)
					 

-- c. Visões:
-- 01 visão que permita inserção
CREATE OR REPLACE VIEW CadastroProduto AS
SELECT fk_categoria_codcategoria_pk, nome, preco
FROM produto

INSERT INTO cadastroproduto values (6,'Caldo de Cana 400ml', 5.00)

-- 02 visões robustas (e.g., com vários joins) com justificativa semântica, de acordo com os requisitos da aplicação.
-- View que permite filtrar os pedidos, nomes do clientes que fizeram o pedido, nome do motoboy que entregou
-- o valor da taxa de entrega e o bairro que corresponde a taxa de entrega
CREATE OR REPLACE VIEW PedidosMotoboy AS
SELECT p.codpedido, c.nome nome_cliente, m.nome nome_motoboy, p.taxa_entrega, c.bairro
FROM motoboy m JOIN pedido p
ON m.codmotoboy = p.fk_motoboy_codmotoboy
JOIN cliente c 
ON c.codcliente = p.fk_cliente_codcliente

-- View que permite saber o nome e o telefone de todos os clientes que fizeram os pedidos da casa
CREATE OR REPLACE VIEW Tel_Clientes_Fidelizados AS
SELECT p.codpedido, c.nome nome_cliente, t.fone
FROM telefone t JOIN cliente c
ON t.fk_cliente_codcliente = c.codcliente
JOIN pedido p 
ON c.codcliente = p.fk_cliente_codcliente


-- Prover acesso a uma das visões para consulta para o usuário 02 (criado).
GRANT SELECT ON PedidosMotoboy TO atendente;


-- d. Índices
--03 índices para campos indicados (além dos referentes às PKs) com justificativa dentro
-- do contexto das consultas formuladas na questão 3b.

-- Indice que melhora a busca quando relacionado a categoria 1 (pizza)
CREATE INDEX idx_pizzas ON produto (fk_categoria_codcategoria_pk) 
WHERE fk_categoria_codcategoria_pk = '1';

EXPLAIN ANALYZE
SELECT *
FROM produto
WHERE fk_categoria_codcategoria_pk = '1';

-- Indice que melhora a busca quando relacionado a preco de lanches abaixo de 8 reais
CREATE INDEX idx_baratos ON produto (preco) 
WHERE preco < 8;

EXPLAIN ANALYZE
SELECT *
FROM produto
WHERE preco < 8;

-- Indice que busca somente por produtos que tenha a quantidade menor que 10 na composição dos pedidos
EXPLAIN ANALYZE
SELECT * FROM compoe

CREATE INDEX idx_qtd_produto ON compoe (quantidade) 
WHERE quantidade < 10;

EXPLAIN ANALYZE
SELECT * FROM compoe

 
-- e. Reescrita de consultas
--Identificar 02 exemplos de consultas dentro do contexto da aplicação (questão
--3.b) que possam e devam ser melhoradas. Reescrevê-las. Justificar a reescrita.
-- Nome de todos os pedidos que aparece o motoboy 'Cachorro_Loko' 
SELECT p.codpedido, p.fk_motoboy_codmotoboy, m.nome
    FROM pedido p JOIN motoboy m
	ON m.codmotoboy = p.fk_motoboy_codmotoboy
	WHERE m.nome = 'Cachorro_Loko'


-- Retorne os dados de todos os clientes que já fizeram pedidos 
SELECT codcliente, nome, rua, bairro, numero 
FROM cliente c JOIN pedido p
ON c.codcliente = p.fk_cliente_codcliente

-- f. Funções ou procedures armazenadas:

-- 01 função que use SUM, MAX, MIN, AVG ou COUNT
-- Funcão que procura pela string fornecida na categoria e retorna o preço médio desta categoria
CREATE OR REPLACE FUNCTION media_preco(busca varchar)
RETURNS varchar AS $$
DECLARE busca varchar = busca;
DECLARE chave varchar = 
			(SELECT ROUND(AVG(p.preco), 2)
			FROM produto p JOIN categoria c
			ON p.fk_categoria_codcategoria_pk = c.codcategoria_pk
			WHERE c.categoria ILIKE busca);
BEGIN
	IF chave IS NOT NULL THEN
		RETURN chave;
	ELSE
		RAISE EXCEPTION 'Esta categoria não existe: "%"', busca;
	END IF;
END;
$$ LANGUAGE plpgsql;

SELECT media_preco('acai')

-- Populando a tabela compoe
INSERT INTO compoe values(40,1,1)
INSERT INTO compoe values(1,1,1)
INSERT INTO compoe values(43,1,1)

INSERT INTO compoe values(5,2,1)
INSERT INTO compoe values(7,2,2)

-- Função que retorna todos os itens de um pedido, sua quantidade e o valor individual de cada produto
CREATE OR REPLACE function CupomFiscal(codpedido1 integer) RETURNS void AS $$
	DECLARE 
		codpedid integer := codpedido1;
		a1 varchar;
		a2 varchar;
		a3 varchar;
		a4 varchar;
		a5 varchar;
		numero RECORD;
		linhas CURSOR IS SELECT fk_pedido_codpedido FROM compoe WHERE fk_pedido_codpedido = codpedid;
	Begin
			SELECT ped.codpedido, ped.valor into a1, a4
			FROM compoe c INNER JOIN produto prod 
			ON fk_produto_codproduto = codproduto
			JOIN pedido ped 
			ON fk_pedido_codpedido = codpedido
			WHERE codpedido = codpedid;
			
			RAISE NOTICE 'Numero do pedido: %', a1;
		
		for numero IN SELECT * FROM compoe c INNER JOIN produto prod 
			ON fk_produto_codproduto = codproduto
			JOIN pedido ped 
			ON fk_pedido_codpedido = codpedido
			WHERE codpedido = codpedid LOOP
			
		RAISE NOTICE E'\nNome do produto: %\nQuantidade: %\nPreco individudal: % ', numero.nome, numero.quantidade, numero.preco;
			
		END LOOP;
		
		RAISE NOTICE 'Preco total: %', a4;

	END; $$ LANGUAGE plpgsql;

-- Rodar com bloco anônimo
Do $$
DECLARE cupom_pedido varchar;
begin
  cupom_pedido = CupomFiscal(1);  
END $$;

-- Ou também rodar ela usando o SELECT
SELECT CupomFiscal(1);

-- DROP FUNCTION CupomFiscal(integer)


      
CREATE OR REPLACE FUNCTION valortotalpedido() RETURNS TRIGGER AS $$
BEGIN
  UPDATE pedido
     SET valor = (SELECT COALESCE(sum(p.preco * quantidade),0)
                    FROM compoe c
                   INNER JOIN produto p ON fk_produto_codproduto = codproduto
                   WHERE c.fk_pedido_codpedido = COALESCE(new.fk_pedido_codpedido,old.fk_pedido_codpedido))
   WHERE codpedido = COALESCE(new.fk_pedido_codpedido,old.fk_pedido_codpedido);

  RETURN NEW;
END;
$$ LANGUAGE plpgsql;
CREATE TRIGGER tg_totalpedido AFTER INSERT OR UPDATE OR DELETE ON compoe FOR EACH ROW EXECUTE PROCEDURE valortotalpedido();

-- Estoque
CREATE OR REPLACE FUNCTION atualizaestoque() RETURNS TRIGGER AS $$
BEGIN
  UPDATE produto
     SET estoque = (SELECT COALESCE(sum(p.estoque - c.quantidade),0)
                    FROM compoe c INNER JOIN produto p 
					ON c.fk_produto_codproduto = p.codproduto
                   WHERE c.fk_produto_codproduto = COALESCE(new.fk_produto_codproduto,old.fk_produto_codproduto))
   WHERE codproduto = COALESCE(new.fk_produto_codproduto,old.fk_produto_codproduto);

  RETURN NEW;
END;
$$ LANGUAGE plpgsql;
CREATE TRIGGER tg_atualizaestoque AFTER INSERT OR UPDATE OR DELETE ON compoe FOR EACH ROW EXECUTE PROCEDURE valortotalpedido();

INSERT INTO compoe values(5,3,1)

INSERT INTO compoe values(1,3,1)
INSERT INTO compoe values(45,2,5)
SELECT * FROM pedido

SELECT * FROM produto

CREATE OR REPLACE function atualizaestoque(codpedido1 integer) RETURNS void AS $$
	DECLARE 
	codpedid integer := codpedido1;
	contador integer := 0;
	percorre RECORD;
	--linhas CURSOR IS SELECT fk_pedido_codpedido FROM compoe WHERE fk_pedido_codpedido = codpedid;
	BEGIN
	for percorre IN (SELECT * FROM compoe c INNER JOIN produto p ON fk_produto_codproduto = p.codproduto WHERE c.fk_pedido_codpedido = codpedid) LOOP
		UPDATE produto SET estoque = (percorre.estoque - percorre.quantidade) WHERE percorre.fk_pedido_codpedido = codpedid AND codproduto = percorre.fk_produto_codproduto;
		RAISE NOTICE '% atualizado', percorre.nome;
	END LOOP;
END; 
$$ LANGUAGE plpgsql;



--03 diferentes triggers com justificativa semântica, de acordo com os requisitos da aplicação.

--Primeira TRIGGER atualização de preço conforme for fazendo a inserção dos itens na tabela pedido
CREATE OR REPLACE FUNCTION valortotalpedido() RETURNS TRIGGER AS $$
BEGIN
  UPDATE pedido
     SET valor = (SELECT COALESCE(sum(p.preco * quantidade),0)
                    FROM compoe c
                   INNER JOIN produto p ON fk_produto_codproduto = codproduto
                   WHERE c.fk_pedido_codpedido = COALESCE(NEW.fk_pedido_codpedido, OLD.fk_pedido_codpedido))
   WHERE codpedido = COALESCE(NEW.fk_pedido_codpedido, OLD.fk_pedido_codpedido);
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;
CREATE TRIGGER tg_totalpedido AFTER INSERT OR UPDATE OR DELETE ON compoe FOR EACH ROW EXECUTE PROCEDURE valortotalpedido();


--Segunda TRIGGER criação da tabela log para monitorar quem for fazendo qualquer atualização na tabela pedido
CREATE TABLE pedLog 
(usuario varchar(20), operacao varchar(10), dataHora timestamp);

DROP TABLE PEDLOG

-- Gera log
CREATE OR REPLACE FUNCTION geraLogDelivery() 
RETURNS TRIGGER AS $$
BEGIN
  INSERT INTO PedLog  (usuario, operacao, dataHora)  
       VALUES (current_user, tg_op, current_timestamp); 
    RETURN NEW; 
END; 
$$ LANGUAGE plpgsql; 

CREATE TRIGGER tg_geraLogDelivery AFTER UPDATE OR INSERT OR DELETE 
  ON pedido FOR EACH ROW 
  EXECUTE PROCEDURE geraLogDelivery();
  
SELECT * FROM pedido; 
SELECT * FROM PedLog;

INSERT INTO pedido (fk_cliente_codcliente, fk_motoboy_codmotoboy, fk_funcionario_codfuncionario, data, status, taxa_entrega)
					VALUES (2, 2,1,current_timestamp, 'Em preparo', 8.00);

UPDATE pedido
SET fk_motoboy_codmotoboy = 2
WHERE codpedido = 6

SELECT * FROM pedido; 
SELECT * FROM PedLog;


--Terceira TRIGGER. Manda mensagem de alerta sempre que um preço for atualizado na tabela produto
CREATE OR REPLACE Function atualizapreco()
RETURNS TRIGGER AS $$
DECLARE msg varchar(40);
Begin
  msg = 'Preco antigo '||old.preco|| ' atualizou para '||new.preco;
  RAISE NOTICE 'O preço foi alterado: %',msg;
  RETURN NULL;
END;
$$ LANGUAGE plpgsql; 
CREATE TRIGGER tg_atualizapreco AFTER UPDATE
  of preco ON produto FOR EACH ROW EXECUTE PROCEDURE atualizapreco();

SELECT * FROM produto;

UPDATE produto SET preco = 1 WHERE codproduto = 42;

SELECT * FROM produto

    
select * from telefone

create or replace function NumeroCliente(codCliente1 integer) returns varchar as $$
	declare
		codcli integer := codcliente1;
		retorno varchar;
	BEGIN
		select fone into retorno from telefone where fk_cliente_codcliente = codcli;
		if retorno is null then
			raise exception 'insira codigo de cliente valido';
		else
			return retorno;
		end if;
	End;
$$ LANGUAGE plpgsql;
 
select NumeroCliente(1);
  
  


								  