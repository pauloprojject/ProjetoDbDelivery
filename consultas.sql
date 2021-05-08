select * from categoria; --ok
select * from cliente; --ok
select * from compoe; 
select * from funcionario; --ok
select * from motoboy; --ok
select * from pedido; --ok
select * from preparado; --ok
select * from produto; --ok
select * from telefone; --ok

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
					 

CREATE OR REPLACE VIEW CadastroProduto AS
SELECT fk_categoria_codcategoria_pk, nome, preco
from produto

INSERT INTO cadastroproduto values (6,'Caldo de Cana 400ml', 5.00)





								  