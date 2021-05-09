delete from categoria
where codcategoria_pk = 7

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
					 

-- 01 visão que permita inserção
CREATE OR REPLACE VIEW CadastroProduto AS
SELECT fk_categoria_codcategoria_pk, nome, preco
from produto

INSERT INTO cadastroproduto values (6,'Caldo de Cana 400ml', 5.00)

CREATE OR REPLACE VIEW 

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

GRANT SELECT ON PedidosMotoboy TO atendente;

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

--


select * from idx_pizzas;
select * from categoria; --ok
select * from cliente; --ok
select * from compoe; 
select * from funcionario; --ok
select * from motoboy; --ok
select * from pedido; --ok
select * from preparado; --ok
select * from produto; --ok
select * from telefone; --ok

-- Procura por produtos com nome que começam com PIZZA e retorna a média do seu preço
SELECT ROUND(AVG(preco), 2) AS media_preco FROM produto WHERE nome ILIKE 'PIZZA%'

-- POSSIVEL FUNÇÃO 
CREATE OR REPLACE FUNCTION media(busca varchar)
RETURNS DECIMAL AS $$
BEGIN
	SELECT ROUND(AVG(preco), 2) AS MEDIA_PRECO FROM produto WHERE nome ILIKE CONCAT('ACAI', '%')
END;
$$ LANGUAGE plpgsql;

--create function to update the value of the order
insert into compoe values(5,1,2)

delete from compoe where fk_pedido_codpedido = 5 

select p.preco * quantidade from compoe c inner join produto p on fk_produto_codproduto = codproduto;

create or replace function TotalPedido(codpedido1 integer) returns void as $$
	declare 
	codpedid integer := codpedido1;
	contador integer := 0;
	--linhas cursor is select fk_pedido_codpedido from compoe where fk_pedido_codpedido = codpedid;
	BEGIN
	--for linha in linhas loop
		contador = contador + (select sum( p.preco * quantidade ) from compoe c inner join produto p on fk_produto_codproduto = codproduto);
	--end loop;
	update pedido set valor = contador where codpedido = codpedid;
	end; $$ LANGUAGE plpgsql;

select TotalPedido(1);
select * from pedido

DROP FUNCTION CupomFiscal(integer)


select valortotal(1)

select ped.codpedido as numero_do_pedido, prod.nome as Nome_do_produto, c.quantidade
from compoe c inner join produto prod 
on fk_produto_codproduto = codproduto
join pedido ped 
on fk_pedido_codpedido = codpedido

create or replace function CupomFiscal(codpedido1 integer) returns varchar as $$
	Declare 
		codpedid integer := codpedido1;
		a1 varchar;
		a2 varchar;
		a3 varchar := '';
		a4 varchar;
		linhas cursor is select fk_pedido_codpedido from compoe where fk_pedido_codpedido = codpedid;
	Begin
		a1 = (select ped.codpedido
		from compoe c inner join produto prod
		on fk_produto_codproduto = codproduto
		join pedido ped 
		on fk_pedido_codpedido = codpedido
		where ped.codpedido = codpedido1);
		a2 = (select prod.nome
		from compoe c inner join produto prod
		on fk_produto_codproduto = codproduto
		join pedido ped 
		on fk_pedido_codpedido = codpedido
		where ped.codpedido = codpedid);
		for linha in linhas loop
		a3 = a3 || '\nQuantidade: x' || (select c.quantidade
		from compoe c inner join produto prod
		on fk_produto_codproduto = codproduto
		join pedido ped 
		on fk_pedido_codpedido = codpedido
		where ped.codpedido = codpedid);
		end loop;
		a4 = (select ped.valor
		from compoe c inner join produto prod
		on fk_produto_codproduto = codproduto
		join pedido ped 
		on fk_pedido_codpedido = codpedido
		where ped.codpedido = codpedid);
		
		return 'Numero do pedido: ' || a1 || '\nNome do produto: ' || a2 || a3 || '\nPreco total: R$' || a4;
	end; $$ LANGUAGE plpgsql;
	
	
Do $$
declare vbonus varchar;
begin
  vbonus = CupomFiscal(1);
  raise notice 'Bonus = % ', vbonus;
end $$;
select CupomFiscal(1);



								  