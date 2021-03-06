toc.dat                                                                                             0000600 0004000 0002000 00000061557 14046346747 0014474 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        PGDMP       7            
        y            Delivery    13.1    13.2 H    !           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false         "           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false         #           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false         $           1262    49598    Delivery    DATABASE     j   CREATE DATABASE "Delivery" WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'Portuguese_Brazil.1252';
    DROP DATABASE "Delivery";
                postgres    false         ?            1255    49774    atualizaestoque()    FUNCTION     ?  CREATE FUNCTION public.atualizaestoque() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  update produto
     set estoque = (select p.estoque - c.quantidade as subtracao
		from compoe c inner join produto p 
			on c.fk_produto_codproduto = p.codproduto
			where c.fk_pedido_codpedido = coalesce(new.fk_pedido_codpedido,old.fk_pedido_codpedido))
		where codproduto = coalesce(new.fk_produto_codproduto,old.fk_produto_codproduto);

  RETURN NEW;
END;
$$;
 (   DROP FUNCTION public.atualizaestoque();
       public          postgres    false         ?            1255    49787    atualizapreco()    FUNCTION        CREATE FUNCTION public.atualizapreco() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
declare msg varchar(40);
Begin
  msg = 'Preco antigo '||old.preco|| ' atualizou para '||new.preco;
  raise notice 'O preço foi alterado: %',msg;
  return null;
End;
$$;
 &   DROP FUNCTION public.atualizapreco();
       public          postgres    false         ?            1255    49794    cupomfiscal(integer)    FUNCTION     ?  CREATE FUNCTION public.cupomfiscal(codpedido1 integer) RETURNS void
    LANGUAGE plpgsql
    AS $$
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

	end; $$;
 6   DROP FUNCTION public.cupomfiscal(codpedido1 integer);
       public          postgres    false         ?            1255    49785    geralogdelivery()    FUNCTION     ?   CREATE FUNCTION public.geralogdelivery() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  INSERT INTO PedLog  (usuario, operacao, dataHora)  
       VALUES (current_user, tg_op, current_timestamp); 
    RETURN NEW; 
END; 
$$;
 (   DROP FUNCTION public.geralogdelivery();
       public          postgres    false         ?            1255    49768    media(character varying)    FUNCTION     ?  CREATE FUNCTION public.media(busca character varying) RETURNS character varying
    LANGUAGE plpgsql
    AS $$
DECLARE busca varchar = busca;
DECLARE chave varchar;
BEGIN
	chave = (SELECT ROUND(AVG(p.preco), 2) AS MEDIA_PRECO 
			FROM produto p join categoria c
			on p.fk_categoria_codcategoria_pk = c.codcategoria_pk
			WHERE c.categoria ILIKE busca);
	if chave is not null then
		return chave;
	else
		raise exception 'Esta categoria não existe: %', busca;
	end if;
END;
$$;
 5   DROP FUNCTION public.media(busca character varying);
       public          postgres    false         ?            1255    49793    media_preco(character varying)    FUNCTION     ?  CREATE FUNCTION public.media_preco(busca character varying) RETURNS character varying
    LANGUAGE plpgsql
    AS $$
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
$$;
 ;   DROP FUNCTION public.media_preco(busca character varying);
       public          postgres    false         ?            1255    49770    totalpedido(integer)    FUNCTION     T  CREATE FUNCTION public.totalpedido(codpedido1 integer) RETURNS void
    LANGUAGE plpgsql
    AS $$
	declare 
	codpedid integer := codpedido1;
	contador integer := 0;
	--linhas cursor is select fk_pedido_codpedido from compoe where fk_pedido_codpedido = codpedid;
	BEGIN
	--for linha in linhas loop
		contador = contador + (select sum( p.preco * c.quantidade ) 
							   from compoe c inner join produto p 
							   on c.fk_produto_codproduto = p.codproduto
							  where c.fk_pedido_codpedido = codpedid);
	--end loop;
	update pedido set valor = contador where codpedido = codpedid;
	end; $$;
 6   DROP FUNCTION public.totalpedido(codpedido1 integer);
       public          postgres    false         ?            1255    49772    valortotalpedido()    FUNCTION     s  CREATE FUNCTION public.valortotalpedido() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  update pedido
     set valor = (select coalesce(sum(p.preco * quantidade),0)
                    from compoe c
                   inner join produto p on fk_produto_codproduto = codproduto
                   where c.fk_pedido_codpedido = coalesce(new.fk_pedido_codpedido,old.fk_pedido_codpedido))
   where codpedido = coalesce(new.fk_pedido_codpedido,old.fk_pedido_codpedido);
  --update produto
    -- set estoque = ()
   --where codproduto = coalesce(new.fk_produto_codproduto,old.fk_produto_codproduto);
  RETURN NEW;
END;
$$;
 )   DROP FUNCTION public.valortotalpedido();
       public          postgres    false         ?            1259    49617    produto    TABLE     ?   CREATE TABLE public.produto (
    codproduto integer NOT NULL,
    fk_categoria_codcategoria_pk integer,
    estoque integer,
    nome character varying(60),
    preco numeric
);
    DROP TABLE public.produto;
       public         heap    postgres    false         ?            1259    49758    cadastroproduto    VIEW     ?   CREATE VIEW public.cadastroproduto AS
 SELECT produto.fk_categoria_codcategoria_pk,
    produto.nome,
    produto.preco
   FROM public.produto;
 "   DROP VIEW public.cadastroproduto;
       public          postgres    false    202    202    202         ?            1259    49648 	   categoria    TABLE     i   CREATE TABLE public.categoria (
    codcategoria_pk integer NOT NULL,
    categoria character varying
);
    DROP TABLE public.categoria;
       public         heap    postgres    false         ?            1259    49730    categoria_codcategoria_pk_seq    SEQUENCE     ?   ALTER TABLE public.categoria ALTER COLUMN codcategoria_pk ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.categoria_codcategoria_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    206         ?            1259    49599    cliente    TABLE     >  CREATE TABLE public.cliente (
    codcliente integer NOT NULL,
    nome character varying,
    rg integer,
    cpf character varying,
    bairro character varying,
    rua character varying,
    numero integer,
    ponto_de_referencia character varying,
    CONSTRAINT tamanhocpf CHECK ((length((cpf)::text) = 11))
);
    DROP TABLE public.cliente;
       public         heap    postgres    false         ?            1259    49728    cliente_codcliente_seq    SEQUENCE     ?   ALTER TABLE public.cliente ALTER COLUMN codcliente ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.cliente_codcliente_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    200         ?            1259    49665    compoe    TABLE     ?   CREATE TABLE public.compoe (
    fk_produto_codproduto integer NOT NULL,
    fk_pedido_codpedido integer NOT NULL,
    quantidade integer NOT NULL
);
    DROP TABLE public.compoe;
       public         heap    postgres    false         ?            1259    49622    funcionario    TABLE     	  CREATE TABLE public.funcionario (
    codfuncionario integer NOT NULL,
    nome character varying,
    funcao character varying,
    salario numeric,
    codgerente integer,
    valortotal numeric,
    CONSTRAINT salariopositivo CHECK ((salario > (0)::numeric))
);
    DROP TABLE public.funcionario;
       public         heap    postgres    false         ?            1259    49732    funcionario_codfuncionario_seq    SEQUENCE     ?   ALTER TABLE public.funcionario ALTER COLUMN codfuncionario ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.funcionario_codfuncionario_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    203         ?            1259    49609    motoboy    TABLE     f   CREATE TABLE public.motoboy (
    codmotoboy integer NOT NULL,
    nome character varying NOT NULL
);
    DROP TABLE public.motoboy;
       public         heap    postgres    false         ?            1259    49734    motoboy_codmotoboy_seq    SEQUENCE     ?   ALTER TABLE public.motoboy ALTER COLUMN codmotoboy ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.motoboy_codmotoboy_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    201         ?            1259    49630    pedido    TABLE     !  CREATE TABLE public.pedido (
    codpedido integer NOT NULL,
    fk_cliente_codcliente integer,
    fk_motoboy_codmotoboy integer,
    fk_funcionario_codfuncionario integer,
    data timestamp without time zone,
    status character varying,
    valor numeric,
    taxa_entrega numeric
);
    DROP TABLE public.pedido;
       public         heap    postgres    false         ?            1259    49736    pedido_codpedido_seq    SEQUENCE     ?   ALTER TABLE public.pedido ALTER COLUMN codpedido ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.pedido_codpedido_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    204         ?            1259    49762    pedidosmotoboy    VIEW     B  CREATE VIEW public.pedidosmotoboy AS
 SELECT p.codpedido,
    c.nome AS nome_cliente,
    m.nome AS nome_motoboy,
    p.taxa_entrega,
    c.bairro
   FROM ((public.motoboy m
     JOIN public.pedido p ON ((m.codmotoboy = p.fk_motoboy_codmotoboy)))
     JOIN public.cliente c ON ((c.codcliente = p.fk_cliente_codcliente)));
 !   DROP VIEW public.pedidosmotoboy;
       public          postgres    false    204    200    200    200    201    201    204    204    204         %           0    0    TABLE pedidosmotoboy    ACL     :   GRANT SELECT ON TABLE public.pedidosmotoboy TO atendente;
          public          postgres    false    216         ?            1259    49789    pedlog    TABLE     ?   CREATE TABLE public.pedlog (
    usuario character varying(20),
    operacao character varying(10),
    datahora timestamp without time zone
);
    DROP TABLE public.pedlog;
       public         heap    postgres    false         ?            1259    49662 	   preparado    TABLE     n   CREATE TABLE public.preparado (
    fk_funcionario_codfuncionario integer,
    fk_pedido_codpedido integer
);
    DROP TABLE public.preparado;
       public         heap    postgres    false         ?            1259    49738    produto_codproduto_seq    SEQUENCE     ?   ALTER TABLE public.produto ALTER COLUMN codproduto ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.produto_codproduto_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    202         ?            1259    49638    telefone    TABLE     ?   CREATE TABLE public.telefone (
    fone character varying NOT NULL,
    fk_cliente_codcliente integer NOT NULL,
    tipo character varying
);
    DROP TABLE public.telefone;
       public         heap    postgres    false                   0    49648 	   categoria 
   TABLE DATA           ?   COPY public.categoria (codcategoria_pk, categoria) FROM stdin;
    public          postgres    false    206       3093.dat           0    49599    cliente 
   TABLE DATA           f   COPY public.cliente (codcliente, nome, rg, cpf, bairro, rua, numero, ponto_de_referencia) FROM stdin;
    public          postgres    false    200       3087.dat           0    49665    compoe 
   TABLE DATA           X   COPY public.compoe (fk_produto_codproduto, fk_pedido_codpedido, quantidade) FROM stdin;
    public          postgres    false    208       3095.dat           0    49622    funcionario 
   TABLE DATA           d   COPY public.funcionario (codfuncionario, nome, funcao, salario, codgerente, valortotal) FROM stdin;
    public          postgres    false    203       3090.dat           0    49609    motoboy 
   TABLE DATA           3   COPY public.motoboy (codmotoboy, nome) FROM stdin;
    public          postgres    false    201       3088.dat           0    49630    pedido 
   TABLE DATA           ?   COPY public.pedido (codpedido, fk_cliente_codcliente, fk_motoboy_codmotoboy, fk_funcionario_codfuncionario, data, status, valor, taxa_entrega) FROM stdin;
    public          postgres    false    204       3091.dat           0    49789    pedlog 
   TABLE DATA           =   COPY public.pedlog (usuario, operacao, datahora) FROM stdin;
    public          postgres    false    217       3102.dat           0    49662 	   preparado 
   TABLE DATA           W   COPY public.preparado (fk_funcionario_codfuncionario, fk_pedido_codpedido) FROM stdin;
    public          postgres    false    207       3094.dat           0    49617    produto 
   TABLE DATA           a   COPY public.produto (codproduto, fk_categoria_codcategoria_pk, estoque, nome, preco) FROM stdin;
    public          postgres    false    202       3089.dat           0    49638    telefone 
   TABLE DATA           E   COPY public.telefone (fone, fk_cliente_codcliente, tipo) FROM stdin;
    public          postgres    false    205       3092.dat &           0    0    categoria_codcategoria_pk_seq    SEQUENCE SET     K   SELECT pg_catalog.setval('public.categoria_codcategoria_pk_seq', 7, true);
          public          postgres    false    210         '           0    0    cliente_codcliente_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('public.cliente_codcliente_seq', 5, true);
          public          postgres    false    209         (           0    0    funcionario_codfuncionario_seq    SEQUENCE SET     L   SELECT pg_catalog.setval('public.funcionario_codfuncionario_seq', 5, true);
          public          postgres    false    211         )           0    0    motoboy_codmotoboy_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('public.motoboy_codmotoboy_seq', 5, true);
          public          postgres    false    212         *           0    0    pedido_codpedido_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public.pedido_codpedido_seq', 6, true);
          public          postgres    false    213         +           0    0    produto_codproduto_seq    SEQUENCE SET     E   SELECT pg_catalog.setval('public.produto_codproduto_seq', 46, true);
          public          postgres    false    214         |           2606    49655    categoria categoria_pkey 
   CONSTRAINT     c   ALTER TABLE ONLY public.categoria
    ADD CONSTRAINT categoria_pkey PRIMARY KEY (codcategoria_pk);
 B   ALTER TABLE ONLY public.categoria DROP CONSTRAINT categoria_pkey;
       public            postgres    false    206         j           2606    49608 %   cliente cliente_codcliente_rg_cpf_key 
   CONSTRAINT     o   ALTER TABLE ONLY public.cliente
    ADD CONSTRAINT cliente_codcliente_rg_cpf_key UNIQUE (codcliente, rg, cpf);
 O   ALTER TABLE ONLY public.cliente DROP CONSTRAINT cliente_codcliente_rg_cpf_key;
       public            postgres    false    200    200    200         l           2606    49606    cliente cliente_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public.cliente
    ADD CONSTRAINT cliente_pkey PRIMARY KEY (codcliente);
 >   ALTER TABLE ONLY public.cliente DROP CONSTRAINT cliente_pkey;
       public            postgres    false    200         t           2606    49629    funcionario funcionario_pkey 
   CONSTRAINT     f   ALTER TABLE ONLY public.funcionario
    ADD CONSTRAINT funcionario_pkey PRIMARY KEY (codfuncionario);
 F   ALTER TABLE ONLY public.funcionario DROP CONSTRAINT funcionario_pkey;
       public            postgres    false    203         n           2606    49616    motoboy motoboy_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public.motoboy
    ADD CONSTRAINT motoboy_pkey PRIMARY KEY (codmotoboy);
 >   ALTER TABLE ONLY public.motoboy DROP CONSTRAINT motoboy_pkey;
       public            postgres    false    201         v           2606    49637    pedido pedido_pkey 
   CONSTRAINT     W   ALTER TABLE ONLY public.pedido
    ADD CONSTRAINT pedido_pkey PRIMARY KEY (codpedido);
 <   ALTER TABLE ONLY public.pedido DROP CONSTRAINT pedido_pkey;
       public            postgres    false    204         r           2606    49621    produto produto_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public.produto
    ADD CONSTRAINT produto_pkey PRIMARY KEY (codproduto);
 >   ALTER TABLE ONLY public.produto DROP CONSTRAINT produto_pkey;
       public            postgres    false    202         x           2606    49647 +   telefone telefone_fk_cliente_codcliente_key 
   CONSTRAINT     w   ALTER TABLE ONLY public.telefone
    ADD CONSTRAINT telefone_fk_cliente_codcliente_key UNIQUE (fk_cliente_codcliente);
 U   ALTER TABLE ONLY public.telefone DROP CONSTRAINT telefone_fk_cliente_codcliente_key;
       public            postgres    false    205         z           2606    49741    telefone telefone_pkey 
   CONSTRAINT     m   ALTER TABLE ONLY public.telefone
    ADD CONSTRAINT telefone_pkey PRIMARY KEY (fk_cliente_codcliente, fone);
 @   ALTER TABLE ONLY public.telefone DROP CONSTRAINT telefone_pkey;
       public            postgres    false    205    205         o           1259    49767    idx_baratos    INDEX     ]   CREATE INDEX idx_baratos ON public.produto USING btree (preco) WHERE (preco < (8)::numeric);
    DROP INDEX public.idx_baratos;
       public            postgres    false    202    202         p           1259    49766 
   idx_pizzas    INDEX        CREATE INDEX idx_pizzas ON public.produto USING btree (fk_categoria_codcategoria_pk) WHERE (fk_categoria_codcategoria_pk = 1);
    DROP INDEX public.idx_pizzas;
       public            postgres    false    202    202         }           1259    49795    idx_qtd_produto    INDEX     `   CREATE INDEX idx_qtd_produto ON public.compoe USING btree (quantidade) WHERE (quantidade < 10);
 #   DROP INDEX public.idx_qtd_produto;
       public            postgres    false    208    208         ?           2620    49777    compoe tg_atualizaestoque    TRIGGER     ?   CREATE TRIGGER tg_atualizaestoque AFTER INSERT OR DELETE OR UPDATE ON public.compoe FOR EACH ROW EXECUTE FUNCTION public.valortotalpedido();
 2   DROP TRIGGER tg_atualizaestoque ON public.compoe;
       public          postgres    false    219    208         ?           2620    49788    produto tg_atualizapreco    TRIGGER     ~   CREATE TRIGGER tg_atualizapreco AFTER UPDATE OF preco ON public.produto FOR EACH ROW EXECUTE FUNCTION public.atualizapreco();
 1   DROP TRIGGER tg_atualizapreco ON public.produto;
       public          postgres    false    202    202    234         ?           2620    49786    pedido tg_geralogdelivery    TRIGGER     ?   CREATE TRIGGER tg_geralogdelivery AFTER INSERT OR DELETE OR UPDATE ON public.pedido FOR EACH ROW EXECUTE FUNCTION public.geralogdelivery();
 2   DROP TRIGGER tg_geralogdelivery ON public.pedido;
       public          postgres    false    204    235         ?           2620    49773    compoe tg_totalpedido    TRIGGER     ?   CREATE TRIGGER tg_totalpedido AFTER INSERT OR DELETE OR UPDATE ON public.compoe FOR EACH ROW EXECUTE FUNCTION public.valortotalpedido();
 .   DROP TRIGGER tg_totalpedido ON public.compoe;
       public          postgres    false    208    219         ?           2606    49713    compoe fk_compoe_1    FK CONSTRAINT     ?   ALTER TABLE ONLY public.compoe
    ADD CONSTRAINT fk_compoe_1 FOREIGN KEY (fk_produto_codproduto) REFERENCES public.produto(codproduto) ON DELETE RESTRICT;
 <   ALTER TABLE ONLY public.compoe DROP CONSTRAINT fk_compoe_1;
       public          postgres    false    2930    202    208         ?           2606    49718    compoe fk_compoe_2    FK CONSTRAINT     ?   ALTER TABLE ONLY public.compoe
    ADD CONSTRAINT fk_compoe_2 FOREIGN KEY (fk_pedido_codpedido) REFERENCES public.pedido(codpedido) ON DELETE RESTRICT;
 <   ALTER TABLE ONLY public.compoe DROP CONSTRAINT fk_compoe_2;
       public          postgres    false    2934    208    204                    2606    49673    pedido fk_pedido_2    FK CONSTRAINT     ?   ALTER TABLE ONLY public.pedido
    ADD CONSTRAINT fk_pedido_2 FOREIGN KEY (fk_cliente_codcliente) REFERENCES public.cliente(codcliente) ON DELETE CASCADE;
 <   ALTER TABLE ONLY public.pedido DROP CONSTRAINT fk_pedido_2;
       public          postgres    false    204    200    2924         ?           2606    49678    pedido fk_pedido_3    FK CONSTRAINT     ?   ALTER TABLE ONLY public.pedido
    ADD CONSTRAINT fk_pedido_3 FOREIGN KEY (fk_motoboy_codmotoboy) REFERENCES public.motoboy(codmotoboy) ON DELETE CASCADE;
 <   ALTER TABLE ONLY public.pedido DROP CONSTRAINT fk_pedido_3;
       public          postgres    false    204    201    2926         ?           2606    49683    pedido fk_pedido_4    FK CONSTRAINT     ?   ALTER TABLE ONLY public.pedido
    ADD CONSTRAINT fk_pedido_4 FOREIGN KEY (fk_funcionario_codfuncionario) REFERENCES public.funcionario(codfuncionario) ON DELETE CASCADE;
 <   ALTER TABLE ONLY public.pedido DROP CONSTRAINT fk_pedido_4;
       public          postgres    false    203    204    2932         ?           2606    49703    preparado fk_preparado_1    FK CONSTRAINT     ?   ALTER TABLE ONLY public.preparado
    ADD CONSTRAINT fk_preparado_1 FOREIGN KEY (fk_funcionario_codfuncionario) REFERENCES public.funcionario(codfuncionario) ON DELETE RESTRICT;
 B   ALTER TABLE ONLY public.preparado DROP CONSTRAINT fk_preparado_1;
       public          postgres    false    2932    203    207         ?           2606    49708    preparado fk_preparado_2    FK CONSTRAINT     ?   ALTER TABLE ONLY public.preparado
    ADD CONSTRAINT fk_preparado_2 FOREIGN KEY (fk_pedido_codpedido) REFERENCES public.pedido(codpedido) ON DELETE SET NULL;
 B   ALTER TABLE ONLY public.preparado DROP CONSTRAINT fk_preparado_2;
       public          postgres    false    204    207    2934         ~           2606    49668    produto fk_produto_2    FK CONSTRAINT     ?   ALTER TABLE ONLY public.produto
    ADD CONSTRAINT fk_produto_2 FOREIGN KEY (fk_categoria_codcategoria_pk) REFERENCES public.categoria(codcategoria_pk);
 >   ALTER TABLE ONLY public.produto DROP CONSTRAINT fk_produto_2;
       public          postgres    false    2940    206    202         ?           2606    49688    telefone fk_telefone_2    FK CONSTRAINT     ?   ALTER TABLE ONLY public.telefone
    ADD CONSTRAINT fk_telefone_2 FOREIGN KEY (fk_cliente_codcliente) REFERENCES public.cliente(codcliente);
 @   ALTER TABLE ONLY public.telefone DROP CONSTRAINT fk_telefone_2;
       public          postgres    false    205    200    2924                                                                                                                                                         3093.dat                                                                                            0000600 0004000 0002000 00000000101 14046346747 0014257 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        1	Pizza
2	Salgado
3	Acai
4	Sobremesas
5	Sanduiche
6	Bebidas
\.


                                                                                                                                                                                                                                                                                                                                                                                                                                                               3087.dat                                                                                            0000600 0004000 0002000 00000000635 14046346747 0014276 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        1	Joao Barbosa	12345	12345678910	Mandacaru	Beco Ze Borges	50	Bar Ze Pinguco
2	Jose Franca	12346	12345678911	Cruz das Armas	Rua do Rio	100	Padaria dos Sonhos
3	Pedro Calixto	12347	12345678912	Camalau	Rua dos Prazeres	2469	Point das Meninas
4	Isaias Abraao	12348	12345678913	Roger	Rua dos Milagres	33	Igreja da Assembleia Madureira
5	Mohamed Alab	12349	12345678914	Geisel	Rua do Estrondo	50	Central de Policia
\.


                                                                                                   3095.dat                                                                                            0000600 0004000 0002000 00000000030 14046346747 0014262 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        5	1	2
4	1	1
45	1	5
\.


                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        3090.dat                                                                                            0000600 0004000 0002000 00000000277 14046346747 0014272 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        5	Rayme Carvalho	Gerente	3200	\N	\N
4	Flaviano Braga	Cozinheiro	1500	5	\N
3	Guaraci Benito	Servico Gerais	1200	5	\N
2	Jorge Pimentel	Atendente	1200	5	\N
1	Joao Jorge	Atendente	1200	5	\N
\.


                                                                                                                                                                                                                                                                                                                                 3088.dat                                                                                            0000600 0004000 0002000 00000000063 14046346747 0014272 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        1	Jefferson
2	Cachorro_Loko
3	Moleque_du_Grau
\.


                                                                                                                                                                                                                                                                                                                                                                                                                                                                             3091.dat                                                                                            0000600 0004000 0002000 00000000506 14046346747 0014266 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        2	2	1	1	2021-05-08 08:49:25.738643	Em preparo	0	8.00
3	2	2	2	2021-05-08 08:49:25.738643	Em preparo	0	8.00
1	1	1	1	2021-05-08 08:44:54.098736	Em preparo	90.0	10
5	5	2	1	2021-05-08 08:49:25.738643	Em preparo	0	9.00
6	2	2	1	2021-05-10 17:58:31.864169	Em preparo	\N	8.00
4	3	2	2	2021-05-08 08:49:25.738643	Em preparo	0	20.00
\.


                                                                                                                                                                                          3102.dat                                                                                            0000600 0004000 0002000 00000000206 14046346747 0014254 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        postgres	UPDATE	2021-05-10 18:42:38.130012
postgres	UPDATE	2021-05-10 20:18:27.410813
postgres	UPDATE	2021-05-10 20:18:27.410813
\.


                                                                                                                                                                                                                                                                                                                                                                                          3094.dat                                                                                            0000600 0004000 0002000 00000000031 14046346747 0014262 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        1	1
1	2
1	3
1	4
1	5
\.


                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       3089.dat                                                                                            0000600 0004000 0002000 00000002475 14046346747 0014304 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        43	6	25	Coca Cola lata	2.5
44	6	35	Coca Cola 1L	4.5
45	6	50	Guarana lata	2.0
46	6	\N	Caldo de Cana 400ml	5.00
1	1	5	Pizza Mista Pequena	20.0
2	1	5	Pizza Mista Média	25.0
3	1	5	Pizza Mista Grande	35.0
4	1	5	Pizza Mista Familia	40.0
5	1	5	Pizza Frango com Catupiry Pequena	20.0
6	1	5	Pizza Frango com Catupiry Média	25.0
7	1	5	Pizza Frango com Catupiry Grande	35.0
8	1	5	Pizza Frango com Catupiry Familia	40.0
9	1	5	Pizza Calabresa Pequena	20.0
10	1	5	Pizza Calabresa Média	25.0
11	1	5	Pizza Calabresa Grande	35.0
12	1	5	Pizza Calabresa Familia	40.0
13	1	5	Pizza Charque Pequena	20.0
14	1	5	Pizza Charque Média	25.0
15	1	5	Pizza Charque Grande	35.0
16	1	5	Pizza Charque Familia	40.0
17	1	5	Pizza A Moda Pequena	20.0
19	1	5	Pizza A Moda Grande	35.0
20	1	5	Pizza A Moda Familia	40.0
21	2	5	Coxinha	3.5
22	2	5	Enroladinho	3.5
23	2	5	Empada	3.5
24	2	5	Pastel de Frango	4.0
25	2	5	Pastel de Carne	3.5
26	2	5	Pastel Misto	4.5
27	3	5	Acai no copo	3.0
28	3	5	Acai Tigela P	5.0
29	3	5	Acai Tigela M	10.0
30	3	5	Acai Tigela G	15.0
31	3	5	Barca Acai	30.0
32	4	5	Torta de chocolate	10.0
33	4	5	Bolo no pote	5.0
34	4	5	Pudim	7.0
35	4	5	Sorvete sabores	7.0
36	5	5	Misto quente	5.0
37	5	5	Hamburguer tradicional	5.0
38	5	5	X-Frango	13.0
39	5	5	X-Calabresa	12.0
40	5	5	X-Egg	14.0
41	5	5	X-Tudo	20.0
18	1	5	Pizza A Moda Média	20
42	6	15	Agua 500ml	1
\.


                                                                                                                                                                                                   3092.dat                                                                                            0000600 0004000 0002000 00000000163 14046346747 0014266 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        83988887777	1	Celular
83988887766	2	Celular
83988887755	3	Celular
83988887744	4	Celular
83988887733	5	Celular
\.


                                                                                                                                                                                                                                                                                                                                                                                                             restore.sql                                                                                         0000600 0004000 0002000 00000052263 14046346747 0015413 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        --
-- NOTE:
--
-- File paths need to be edited. Search for $$PATH$$ and
-- replace it with the path to the directory containing
-- the extracted data files.
--
--
-- PostgreSQL database dump
--

-- Dumped from database version 13.1
-- Dumped by pg_dump version 13.2

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

DROP DATABASE "Delivery";
--
-- Name: Delivery; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE "Delivery" WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'Portuguese_Brazil.1252';


ALTER DATABASE "Delivery" OWNER TO postgres;

\connect "Delivery"

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: atualizaestoque(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.atualizaestoque() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  update produto
     set estoque = (select p.estoque - c.quantidade as subtracao
		from compoe c inner join produto p 
			on c.fk_produto_codproduto = p.codproduto
			where c.fk_pedido_codpedido = coalesce(new.fk_pedido_codpedido,old.fk_pedido_codpedido))
		where codproduto = coalesce(new.fk_produto_codproduto,old.fk_produto_codproduto);

  RETURN NEW;
END;
$$;


ALTER FUNCTION public.atualizaestoque() OWNER TO postgres;

--
-- Name: atualizapreco(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.atualizapreco() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
declare msg varchar(40);
Begin
  msg = 'Preco antigo '||old.preco|| ' atualizou para '||new.preco;
  raise notice 'O preço foi alterado: %',msg;
  return null;
End;
$$;


ALTER FUNCTION public.atualizapreco() OWNER TO postgres;

--
-- Name: cupomfiscal(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.cupomfiscal(codpedido1 integer) RETURNS void
    LANGUAGE plpgsql
    AS $$
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

	end; $$;


ALTER FUNCTION public.cupomfiscal(codpedido1 integer) OWNER TO postgres;

--
-- Name: geralogdelivery(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.geralogdelivery() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  INSERT INTO PedLog  (usuario, operacao, dataHora)  
       VALUES (current_user, tg_op, current_timestamp); 
    RETURN NEW; 
END; 
$$;


ALTER FUNCTION public.geralogdelivery() OWNER TO postgres;

--
-- Name: media(character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.media(busca character varying) RETURNS character varying
    LANGUAGE plpgsql
    AS $$
DECLARE busca varchar = busca;
DECLARE chave varchar;
BEGIN
	chave = (SELECT ROUND(AVG(p.preco), 2) AS MEDIA_PRECO 
			FROM produto p join categoria c
			on p.fk_categoria_codcategoria_pk = c.codcategoria_pk
			WHERE c.categoria ILIKE busca);
	if chave is not null then
		return chave;
	else
		raise exception 'Esta categoria não existe: %', busca;
	end if;
END;
$$;


ALTER FUNCTION public.media(busca character varying) OWNER TO postgres;

--
-- Name: media_preco(character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.media_preco(busca character varying) RETURNS character varying
    LANGUAGE plpgsql
    AS $$
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
$$;


ALTER FUNCTION public.media_preco(busca character varying) OWNER TO postgres;

--
-- Name: totalpedido(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.totalpedido(codpedido1 integer) RETURNS void
    LANGUAGE plpgsql
    AS $$
	declare 
	codpedid integer := codpedido1;
	contador integer := 0;
	--linhas cursor is select fk_pedido_codpedido from compoe where fk_pedido_codpedido = codpedid;
	BEGIN
	--for linha in linhas loop
		contador = contador + (select sum( p.preco * c.quantidade ) 
							   from compoe c inner join produto p 
							   on c.fk_produto_codproduto = p.codproduto
							  where c.fk_pedido_codpedido = codpedid);
	--end loop;
	update pedido set valor = contador where codpedido = codpedid;
	end; $$;


ALTER FUNCTION public.totalpedido(codpedido1 integer) OWNER TO postgres;

--
-- Name: valortotalpedido(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.valortotalpedido() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  update pedido
     set valor = (select coalesce(sum(p.preco * quantidade),0)
                    from compoe c
                   inner join produto p on fk_produto_codproduto = codproduto
                   where c.fk_pedido_codpedido = coalesce(new.fk_pedido_codpedido,old.fk_pedido_codpedido))
   where codpedido = coalesce(new.fk_pedido_codpedido,old.fk_pedido_codpedido);
  --update produto
    -- set estoque = ()
   --where codproduto = coalesce(new.fk_produto_codproduto,old.fk_produto_codproduto);
  RETURN NEW;
END;
$$;


ALTER FUNCTION public.valortotalpedido() OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: produto; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.produto (
    codproduto integer NOT NULL,
    fk_categoria_codcategoria_pk integer,
    estoque integer,
    nome character varying(60),
    preco numeric
);


ALTER TABLE public.produto OWNER TO postgres;

--
-- Name: cadastroproduto; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.cadastroproduto AS
 SELECT produto.fk_categoria_codcategoria_pk,
    produto.nome,
    produto.preco
   FROM public.produto;


ALTER TABLE public.cadastroproduto OWNER TO postgres;

--
-- Name: categoria; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.categoria (
    codcategoria_pk integer NOT NULL,
    categoria character varying
);


ALTER TABLE public.categoria OWNER TO postgres;

--
-- Name: categoria_codcategoria_pk_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.categoria ALTER COLUMN codcategoria_pk ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.categoria_codcategoria_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: cliente; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cliente (
    codcliente integer NOT NULL,
    nome character varying,
    rg integer,
    cpf character varying,
    bairro character varying,
    rua character varying,
    numero integer,
    ponto_de_referencia character varying,
    CONSTRAINT tamanhocpf CHECK ((length((cpf)::text) = 11))
);


ALTER TABLE public.cliente OWNER TO postgres;

--
-- Name: cliente_codcliente_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.cliente ALTER COLUMN codcliente ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.cliente_codcliente_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: compoe; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.compoe (
    fk_produto_codproduto integer NOT NULL,
    fk_pedido_codpedido integer NOT NULL,
    quantidade integer NOT NULL
);


ALTER TABLE public.compoe OWNER TO postgres;

--
-- Name: funcionario; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.funcionario (
    codfuncionario integer NOT NULL,
    nome character varying,
    funcao character varying,
    salario numeric,
    codgerente integer,
    valortotal numeric,
    CONSTRAINT salariopositivo CHECK ((salario > (0)::numeric))
);


ALTER TABLE public.funcionario OWNER TO postgres;

--
-- Name: funcionario_codfuncionario_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.funcionario ALTER COLUMN codfuncionario ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.funcionario_codfuncionario_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: motoboy; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.motoboy (
    codmotoboy integer NOT NULL,
    nome character varying NOT NULL
);


ALTER TABLE public.motoboy OWNER TO postgres;

--
-- Name: motoboy_codmotoboy_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.motoboy ALTER COLUMN codmotoboy ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.motoboy_codmotoboy_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: pedido; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.pedido (
    codpedido integer NOT NULL,
    fk_cliente_codcliente integer,
    fk_motoboy_codmotoboy integer,
    fk_funcionario_codfuncionario integer,
    data timestamp without time zone,
    status character varying,
    valor numeric,
    taxa_entrega numeric
);


ALTER TABLE public.pedido OWNER TO postgres;

--
-- Name: pedido_codpedido_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.pedido ALTER COLUMN codpedido ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.pedido_codpedido_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: pedidosmotoboy; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.pedidosmotoboy AS
 SELECT p.codpedido,
    c.nome AS nome_cliente,
    m.nome AS nome_motoboy,
    p.taxa_entrega,
    c.bairro
   FROM ((public.motoboy m
     JOIN public.pedido p ON ((m.codmotoboy = p.fk_motoboy_codmotoboy)))
     JOIN public.cliente c ON ((c.codcliente = p.fk_cliente_codcliente)));


ALTER TABLE public.pedidosmotoboy OWNER TO postgres;

--
-- Name: pedlog; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.pedlog (
    usuario character varying(20),
    operacao character varying(10),
    datahora timestamp without time zone
);


ALTER TABLE public.pedlog OWNER TO postgres;

--
-- Name: preparado; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.preparado (
    fk_funcionario_codfuncionario integer,
    fk_pedido_codpedido integer
);


ALTER TABLE public.preparado OWNER TO postgres;

--
-- Name: produto_codproduto_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.produto ALTER COLUMN codproduto ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.produto_codproduto_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: telefone; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.telefone (
    fone character varying NOT NULL,
    fk_cliente_codcliente integer NOT NULL,
    tipo character varying
);


ALTER TABLE public.telefone OWNER TO postgres;

--
-- Data for Name: categoria; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.categoria (codcategoria_pk, categoria) FROM stdin;
\.
COPY public.categoria (codcategoria_pk, categoria) FROM '$$PATH$$/3093.dat';

--
-- Data for Name: cliente; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cliente (codcliente, nome, rg, cpf, bairro, rua, numero, ponto_de_referencia) FROM stdin;
\.
COPY public.cliente (codcliente, nome, rg, cpf, bairro, rua, numero, ponto_de_referencia) FROM '$$PATH$$/3087.dat';

--
-- Data for Name: compoe; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.compoe (fk_produto_codproduto, fk_pedido_codpedido, quantidade) FROM stdin;
\.
COPY public.compoe (fk_produto_codproduto, fk_pedido_codpedido, quantidade) FROM '$$PATH$$/3095.dat';

--
-- Data for Name: funcionario; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.funcionario (codfuncionario, nome, funcao, salario, codgerente, valortotal) FROM stdin;
\.
COPY public.funcionario (codfuncionario, nome, funcao, salario, codgerente, valortotal) FROM '$$PATH$$/3090.dat';

--
-- Data for Name: motoboy; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.motoboy (codmotoboy, nome) FROM stdin;
\.
COPY public.motoboy (codmotoboy, nome) FROM '$$PATH$$/3088.dat';

--
-- Data for Name: pedido; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.pedido (codpedido, fk_cliente_codcliente, fk_motoboy_codmotoboy, fk_funcionario_codfuncionario, data, status, valor, taxa_entrega) FROM stdin;
\.
COPY public.pedido (codpedido, fk_cliente_codcliente, fk_motoboy_codmotoboy, fk_funcionario_codfuncionario, data, status, valor, taxa_entrega) FROM '$$PATH$$/3091.dat';

--
-- Data for Name: pedlog; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.pedlog (usuario, operacao, datahora) FROM stdin;
\.
COPY public.pedlog (usuario, operacao, datahora) FROM '$$PATH$$/3102.dat';

--
-- Data for Name: preparado; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.preparado (fk_funcionario_codfuncionario, fk_pedido_codpedido) FROM stdin;
\.
COPY public.preparado (fk_funcionario_codfuncionario, fk_pedido_codpedido) FROM '$$PATH$$/3094.dat';

--
-- Data for Name: produto; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.produto (codproduto, fk_categoria_codcategoria_pk, estoque, nome, preco) FROM stdin;
\.
COPY public.produto (codproduto, fk_categoria_codcategoria_pk, estoque, nome, preco) FROM '$$PATH$$/3089.dat';

--
-- Data for Name: telefone; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.telefone (fone, fk_cliente_codcliente, tipo) FROM stdin;
\.
COPY public.telefone (fone, fk_cliente_codcliente, tipo) FROM '$$PATH$$/3092.dat';

--
-- Name: categoria_codcategoria_pk_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.categoria_codcategoria_pk_seq', 7, true);


--
-- Name: cliente_codcliente_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.cliente_codcliente_seq', 5, true);


--
-- Name: funcionario_codfuncionario_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.funcionario_codfuncionario_seq', 5, true);


--
-- Name: motoboy_codmotoboy_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.motoboy_codmotoboy_seq', 5, true);


--
-- Name: pedido_codpedido_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.pedido_codpedido_seq', 6, true);


--
-- Name: produto_codproduto_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.produto_codproduto_seq', 46, true);


--
-- Name: categoria categoria_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categoria
    ADD CONSTRAINT categoria_pkey PRIMARY KEY (codcategoria_pk);


--
-- Name: cliente cliente_codcliente_rg_cpf_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cliente
    ADD CONSTRAINT cliente_codcliente_rg_cpf_key UNIQUE (codcliente, rg, cpf);


--
-- Name: cliente cliente_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cliente
    ADD CONSTRAINT cliente_pkey PRIMARY KEY (codcliente);


--
-- Name: funcionario funcionario_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.funcionario
    ADD CONSTRAINT funcionario_pkey PRIMARY KEY (codfuncionario);


--
-- Name: motoboy motoboy_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.motoboy
    ADD CONSTRAINT motoboy_pkey PRIMARY KEY (codmotoboy);


--
-- Name: pedido pedido_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pedido
    ADD CONSTRAINT pedido_pkey PRIMARY KEY (codpedido);


--
-- Name: produto produto_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.produto
    ADD CONSTRAINT produto_pkey PRIMARY KEY (codproduto);


--
-- Name: telefone telefone_fk_cliente_codcliente_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.telefone
    ADD CONSTRAINT telefone_fk_cliente_codcliente_key UNIQUE (fk_cliente_codcliente);


--
-- Name: telefone telefone_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.telefone
    ADD CONSTRAINT telefone_pkey PRIMARY KEY (fk_cliente_codcliente, fone);


--
-- Name: idx_baratos; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_baratos ON public.produto USING btree (preco) WHERE (preco < (8)::numeric);


--
-- Name: idx_pizzas; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_pizzas ON public.produto USING btree (fk_categoria_codcategoria_pk) WHERE (fk_categoria_codcategoria_pk = 1);


--
-- Name: idx_qtd_produto; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_qtd_produto ON public.compoe USING btree (quantidade) WHERE (quantidade < 10);


--
-- Name: compoe tg_atualizaestoque; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER tg_atualizaestoque AFTER INSERT OR DELETE OR UPDATE ON public.compoe FOR EACH ROW EXECUTE FUNCTION public.valortotalpedido();


--
-- Name: produto tg_atualizapreco; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER tg_atualizapreco AFTER UPDATE OF preco ON public.produto FOR EACH ROW EXECUTE FUNCTION public.atualizapreco();


--
-- Name: pedido tg_geralogdelivery; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER tg_geralogdelivery AFTER INSERT OR DELETE OR UPDATE ON public.pedido FOR EACH ROW EXECUTE FUNCTION public.geralogdelivery();


--
-- Name: compoe tg_totalpedido; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER tg_totalpedido AFTER INSERT OR DELETE OR UPDATE ON public.compoe FOR EACH ROW EXECUTE FUNCTION public.valortotalpedido();


--
-- Name: compoe fk_compoe_1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.compoe
    ADD CONSTRAINT fk_compoe_1 FOREIGN KEY (fk_produto_codproduto) REFERENCES public.produto(codproduto) ON DELETE RESTRICT;


--
-- Name: compoe fk_compoe_2; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.compoe
    ADD CONSTRAINT fk_compoe_2 FOREIGN KEY (fk_pedido_codpedido) REFERENCES public.pedido(codpedido) ON DELETE RESTRICT;


--
-- Name: pedido fk_pedido_2; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pedido
    ADD CONSTRAINT fk_pedido_2 FOREIGN KEY (fk_cliente_codcliente) REFERENCES public.cliente(codcliente) ON DELETE CASCADE;


--
-- Name: pedido fk_pedido_3; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pedido
    ADD CONSTRAINT fk_pedido_3 FOREIGN KEY (fk_motoboy_codmotoboy) REFERENCES public.motoboy(codmotoboy) ON DELETE CASCADE;


--
-- Name: pedido fk_pedido_4; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pedido
    ADD CONSTRAINT fk_pedido_4 FOREIGN KEY (fk_funcionario_codfuncionario) REFERENCES public.funcionario(codfuncionario) ON DELETE CASCADE;


--
-- Name: preparado fk_preparado_1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.preparado
    ADD CONSTRAINT fk_preparado_1 FOREIGN KEY (fk_funcionario_codfuncionario) REFERENCES public.funcionario(codfuncionario) ON DELETE RESTRICT;


--
-- Name: preparado fk_preparado_2; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.preparado
    ADD CONSTRAINT fk_preparado_2 FOREIGN KEY (fk_pedido_codpedido) REFERENCES public.pedido(codpedido) ON DELETE SET NULL;


--
-- Name: produto fk_produto_2; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.produto
    ADD CONSTRAINT fk_produto_2 FOREIGN KEY (fk_categoria_codcategoria_pk) REFERENCES public.categoria(codcategoria_pk);


--
-- Name: telefone fk_telefone_2; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.telefone
    ADD CONSTRAINT fk_telefone_2 FOREIGN KEY (fk_cliente_codcliente) REFERENCES public.cliente(codcliente);


--
-- Name: TABLE pedidosmotoboy; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.pedidosmotoboy TO atendente;


--
-- PostgreSQL database dump complete
--

                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             