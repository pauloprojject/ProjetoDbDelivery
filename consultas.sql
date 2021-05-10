-- b) ii 01 consulta usando between
select * 
from funcionario 
where salario between 1000 and 2000

-- b) ii 03 consultas usando join
--Selecione o nome do motoboy e o código do pedido que ele fez a entrega
select p.codpedido, m.nome
from pedido p inner join motoboy m
on p.fk_motoboy_codmotoboy = m.codmotoboy

--Selecione o nome do funcionario e o código do pedido que ele atendeu
select p.codpedido, f.nome
from pedido p inner join funcionario f
on p.fk_funcionario_codfuncionario = f.codfuncionario

--Selecione todos os produtos da categoria Pizza
select p.nome
from produto p inner join categoria c
on p.fk_categoria_codcategoria_pk = c.codcategoria_pk
where c.categoria = 'Pizza'

-- 01 consulta com left/right/full outer join na cláusula FROM
--Selecione os clientes que ainda não tem pedido
select c.codcliente, c.nome, p.codpedido
from cliente c left join pedido p
on c.codcliente = p.fk_cliente_codcliente
where codpedido is null

-- 02 consultas usando group by
-- Consulte quantos produtos estão cadastrado por categoria
select  c.categoria as nome_categoria, count(p.fk_categoria_codcategoria_pk)
from produto p join categoria c
on p.fk_categoria_codcategoria_pk = c.codcategoria_pk
group by nome_categoria

-- Quantos produtos tem estoque maior que 30 unidades na categoria bebidas
select p.estoque, p.nome
from produto p join categoria c
on p.fk_categoria_codcategoria_pk = c.codcategoria_pk
group by p.estoque, p.nome, c.categoria
having p.estoque > 30 and c.categoria = 'Bebidas'


-- consulta usando alguma operação de conjunto (union, except ou intersect)
-- Selecione todos os nomes e papeis de possiveis envolvidos na formação de um pedido
select nome, 'Funcionario' as Identidade
from funcionario

union

select nome, 'Cliente'
from cliente

union

select nome, 'Motoboy'
from motoboy
order by Identidade

-- 02 consultas que usem subqueries.
-- Retorne uma consulta usando subquery dos pedidos que o motoboy 'Cachorro_Loko' entregou	
select p.codpedido, p.fk_motoboy_codmotoboy, (select m.nome from motoboy m where m.nome = 'Cachorro_Loko')
    From pedido p
	Where p.fk_motoboy_codmotoboy in (select m.codmotoboy
									 from motoboy m join pedido p
									 on p.fk_motoboy_codmotoboy = m.codmotoboy
									 where m.nome = 'Cachorro_Loko')	
									 

-- Retorne os dados de todos os clientes que já fizeram pedidos 
SELECT codcliente, nome, rua, bairro, numero 
from cliente 
where codcliente in (SELECT fk_cliente_codcliente 
					 FROM pedido 
					 WHERE cliente.codcliente = pedido.fk_cliente_codcliente)
					 

-- c. Visões:
-- 01 visão que permita inserção
CREATE OR REPLACE VIEW CadastroProduto AS
SELECT fk_categoria_codcategoria_pk, nome, preco
from produto

INSERT INTO cadastroproduto values (6,'Caldo de Cana 400ml', 5.00)

-- 02 visões robustas (e.g., com vários joins) com justificativa semântica, de acordo com os requisitos da aplicação.
-- View que permite filtrar os pedidos, nomes do clientes que fizeram o pedido, nome do motoboy que entregou
-- o valor da taxa de entrega e o bairro que corresponde a taxa de entrega
CREATE OR REPLACE VIEW PedidosMotoboy AS
SELECT p.codpedido, c.nome nome_cliente, m.nome nome_motoboy, p.taxa_entrega, c.bairro
from motoboy m join pedido p
on m.codmotoboy = p.fk_motoboy_codmotoboy
join cliente c 
on c.codcliente = p.fk_cliente_codcliente

-- View que permite saber o nome e o telefone de todos os clientes que fizeram os pedidos da casa
CREATE OR REPLACE VIEW Tel_Clientes_Fidelizados AS
SELECT p.codpedido, c.nome nome_cliente, t.fone
from telefone t join cliente c
on t.fk_cliente_codcliente = c.codcliente
join pedido p 
on c.codcliente = p.fk_cliente_codcliente


-- Prover acesso a uma das visões para consulta para o usuário 02 (criado).
GRANT SELECT ON PedidosMotoboy TO atendente;


-- d. Índices
--03 índices para campos indicados (além dos referentes às PKs) com justificativa dentro
-- do contexto das consultas formuladas na questão 3b.

-- Indice que melhora a busca quando relacionado a categoria 1 (pizza)
CREATE INDEX idx_pizzas on produto (fk_categoria_codcategoria_pk) 
WHERE fk_categoria_codcategoria_pk = '1';

explain analyze
select *
from produto
WHERE fk_categoria_codcategoria_pk = '1';

-- Indice que melhora a busca quando relacionado a preco de lanches abaixo de 8 reais
CREATE INDEX idx_baratos on produto (preco) 
WHERE preco < 8;

explain analyze
select *
from produto
WHERE preco < 8;

-- Indice que busca somente por produtos que tenha a quantidade menor que 10 na composição dos pedidos
explain analyze
select * from compoe

CREATE INDEX idx_qtd_produto on compoe (quantidade) 
WHERE quantidade < 10;

explain analyze
select * from compoe

 
-- e. Reescrita de consultas
--Identificar 02 exemplos de consultas dentro do contexto da aplicação (questão
--3.b) que possam e devam ser melhoradas. Reescrevê-las. Justificar a reescrita.
-- Nome de todos os pedidos que aparece o motoboy 'Cachorro_Loko' 
select p.codpedido, p.fk_motoboy_codmotoboy, m.nome
    From pedido p join motoboy m
	on m.codmotoboy = p.fk_motoboy_codmotoboy
	where m.nome = 'Cachorro_Loko'


-- Retorne os dados de todos os clientes que já fizeram pedidos 
SELECT codcliente, nome, rua, bairro, numero 
from cliente c join pedido p
on c.codcliente = p.fk_cliente_codcliente

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
	IF chave IS NOT null THEN
		RETURN chave;
	ELSE
		RAISE EXCEPTION 'Esta categoria não existe: "%"', busca;
	END IF;
END;
$$ LANGUAGE plpgsql;

select media_preco('acai')

-- Populando a tabela compoe
insert into compoe values(40,1,1)
insert into compoe values(1,1,1)
insert into compoe values(43,1,1)

insert into compoe values(5,2,1)
insert into compoe values(7,2,2)

-- Função que retorna todos os itens de um pedido, sua quantidade e o valor individual de cada produto
create or replace function CupomFiscal(codpedido1 integer) returns void as $$
	Declare 
		codpedid integer := codpedido1;
		a1 varchar;
		a2 varchar;
		a3 varchar;
		a4 varchar;
		a5 varchar;
		numero RECORD;
		linhas cursor is select fk_pedido_codpedido from compoe where fk_pedido_codpedido = codpedid;
	Begin
			select ped.codpedido, ped.valor into a1, a4
			from compoe c inner join produto prod 
			on fk_produto_codproduto = codproduto
			join pedido ped 
			on fk_pedido_codpedido = codpedido
			where codpedido = codpedid;
			
			raise notice 'Numero do pedido: %', a1;
		
		for numero in select * from compoe c inner join produto prod 
			on fk_produto_codproduto = codproduto
			join pedido ped 
			on fk_pedido_codpedido = codpedido
			where codpedido = codpedid loop
			
		raise notice E'\nNome do produto: %\nQuantidade: %\nPreco individudal: % ', numero.nome, numero.quantidade, numero.preco;
			
		end loop;
		
		raise notice 'Preco total: %', a4;
		EXCEPTION
			when NO_DATA_FOUND then
				raise exception 'Entre um pedido válido';

	end; $$ LANGUAGE plpgsql;

-- Rodar com bloco anônimo
Do $$
declare vbonus varchar;
begin
  vbonus = CupomFiscal(1);  
end $$;

-- Ou também rodar ela usando o select
select CupomFiscal(1);

-- DROP FUNCTION CupomFiscal(integer)


      
CREATE OR REPLACE FUNCTION valortotalpedido() RETURNS trigger AS $$
BEGIN
  update pedido
     set valor = (select coalesce(sum(p.preco * quantidade),0)
                    from compoe c
                   inner join produto p on fk_produto_codproduto = codproduto
                   where c.fk_pedido_codpedido = coalesce(new.fk_pedido_codpedido,old.fk_pedido_codpedido))
   where codpedido = coalesce(new.fk_pedido_codpedido,old.fk_pedido_codpedido);

  RETURN NEW;
END;
$$ LANGUAGE plpgsql;
CREATE TRIGGER tg_totalpedido AFTER INSERT OR UPDATE OR DELETE ON compoe FOR EACH ROW EXECUTE PROCEDURE valortotalpedido();
--estoque
CREATE OR REPLACE FUNCTION atualizaestoque() RETURNS trigger AS $$
BEGIN
  update produto
     set estoque = (select coalesce(sum(p.estoque - c.quantidade),0)
                    from compoe c inner join produto p 
					on c.fk_produto_codproduto = p.codproduto
                   where c.fk_produto_codproduto = coalesce(new.fk_produto_codproduto,old.fk_produto_codproduto))
   where codproduto = coalesce(new.fk_produto_codproduto,old.fk_produto_codproduto);

  RETURN NEW;
END;
$$ LANGUAGE plpgsql;
CREATE TRIGGER tg_atualizaestoque AFTER INSERT OR UPDATE OR DELETE ON compoe FOR EACH ROW EXECUTE PROCEDURE valortotalpedido();

insert into compoe values(5,3,1)

insert into compoe values(1,3,4)
insert into compoe values(45,2,5)
select * from pedido

select * from produto

create or replace function atualizaestoque(codpedido1 integer) returns void as $$
	declare 
	codpedid integer := codpedido1;
	contador integer := 0;
	percorre RECORD;
	--linhas cursor is select fk_pedido_codpedido from compoe where fk_pedido_codpedido = codpedid;
	BEGIN
	for percorre in (select * from compoe c inner join produto p on fk_produto_codproduto = p.codproduto where c.fk_pedido_codpedido = codpedid) loop
		update produto set estoque = (percorre.estoque - percorre.quantidade) where percorre.fk_pedido_codpedido = codpedid and codproduto = percorre.fk_produto_codproduto;
		raise notice '% atualizado', percorre.nome;
		if percorre.estoque < 0 then
			update produto set estoque = 0 where percorre.fk_pedido_codpedido = codpedid and codproduto = percorre.fk_produto_codproduto;
		end if;
	end loop;
	
	end; $$ LANGUAGE plpgsql;



--03 diferentes triggers com justificativa semântica, de acordo com os requisitos da aplicação.

--Primeira Trigger atualização de preço conforme for fazendo a inserção dos itens na tabela pedido
CREATE OR REPLACE FUNCTION valortotalpedido() RETURNS trigger AS $$
BEGIN
  update pedido
     set valor = (select coalesce(sum(p.preco * quantidade),0)
                    from compoe c
                   inner join produto p on fk_produto_codproduto = codproduto
                   where c.fk_pedido_codpedido = coalesce(new.fk_pedido_codpedido,old.fk_pedido_codpedido))
   where codpedido = coalesce(new.fk_pedido_codpedido,old.fk_pedido_codpedido);

  RETURN NEW;
END;
$$ LANGUAGE plpgsql;
CREATE TRIGGER tg_totalpedido AFTER INSERT OR UPDATE OR DELETE ON compoe FOR EACH ROW EXECUTE PROCEDURE valortotalpedido();


--Segunda Trigger criação da tabela log para monitorar quem for fazendo qualquer atualização na tabela pedido
create table 
pedLog 
(usuario varchar(20), operacao varchar(10), dataHora timestamp);

DROP TABLE PEDLOG

-- Gera log
CREATE OR REPLACE FUNCTION geraLogDelivery() 
RETURNS trigger AS $$
BEGIN
  INSERT INTO PedLog  (usuario, operacao, dataHora)  
       VALUES (current_user, tg_op, current_timestamp); 
    RETURN NEW; 
END; 
$$ LANGUAGE plpgsql; 

CREATE TRIGGER tg_geraLogDelivery AFTER UPDATE or INSERT or DELETE 
  ON pedido FOR EACH ROW 
  EXECUTE PROCEDURE geraLogDelivery();
  
select * from pedido; 
select * from PedLog;

INSERT INTO pedido (fk_cliente_codcliente, fk_motoboy_codmotoboy, fk_funcionario_codfuncionario, data, status, taxa_entrega)
					VALUES (2, 2,1,current_timestamp, 'Em preparo', 8.00);

update pedido
SET fk_motoboy_codmotoboy = 2
where codpedido = 6

select * from pedido; 
select * from PedLog;


--Terceira Trigger. Manda mensagem de alerta sempre que um preço for atualizado na tabela produto
Create or Replace Function atualizapreco()
Returns trigger as $$
declare msg varchar(40);
Begin
  msg = 'Preco antigo '||old.preco|| ' atualizou para '||new.preco;
  raise notice 'O preço foi alterado: %',msg;
  return null;
End;
$$ LANGUAGE plpgsql; 
CREATE TRIGGER tg_atualizapreco AFTER UPDATE
  of preco ON produto FOR EACH ROW EXECUTE PROCEDURE atualizapreco();

select * from produto;

update produto set preco = 1 where codproduto = 42;

select * from produto

    
    
  
  


								  