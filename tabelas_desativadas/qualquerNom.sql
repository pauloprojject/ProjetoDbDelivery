toc.dat                                                                                             0000600 0004000 0002000 00000037214 14045546121 0014450 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        PGDMP           %                y            Delivery    13.1    13.2 4               0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false                    0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false                    0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false                    1262    49598    Delivery    DATABASE     j   CREATE DATABASE "Delivery" WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'Portuguese_Brazil.1252';
    DROP DATABASE "Delivery";
                postgres    false         ?            1259    49648 	   categoria    TABLE     i   CREATE TABLE public.categoria (
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
            public          postgres    false    204         ?            1259    49662 	   preparado    TABLE     n   CREATE TABLE public.preparado (
    fk_funcionario_codfuncionario integer,
    fk_pedido_codpedido integer
);
    DROP TABLE public.preparado;
       public         heap    postgres    false         ?            1259    49617    produto    TABLE     ?   CREATE TABLE public.produto (
    codproduto integer NOT NULL,
    fk_categoria_codcategoria_pk integer,
    estoque integer,
    nome character varying(60),
    preco numeric
);
    DROP TABLE public.produto;
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
       public         heap    postgres    false         ?          0    49648 	   categoria 
   TABLE DATA           ?   COPY public.categoria (codcategoria_pk, categoria) FROM stdin;
    public          postgres    false    206       3064.dat ?          0    49599    cliente 
   TABLE DATA           f   COPY public.cliente (codcliente, nome, rg, cpf, bairro, rua, numero, ponto_de_referencia) FROM stdin;
    public          postgres    false    200       3058.dat ?          0    49665    compoe 
   TABLE DATA           X   COPY public.compoe (fk_produto_codproduto, fk_pedido_codpedido, quantidade) FROM stdin;
    public          postgres    false    208       3066.dat ?          0    49622    funcionario 
   TABLE DATA           d   COPY public.funcionario (codfuncionario, nome, funcao, salario, codgerente, valortotal) FROM stdin;
    public          postgres    false    203       3061.dat ?          0    49609    motoboy 
   TABLE DATA           3   COPY public.motoboy (codmotoboy, nome) FROM stdin;
    public          postgres    false    201       3059.dat ?          0    49630    pedido 
   TABLE DATA           ?   COPY public.pedido (codpedido, fk_cliente_codcliente, fk_motoboy_codmotoboy, fk_funcionario_codfuncionario, data, status, valor, taxa_entrega) FROM stdin;
    public          postgres    false    204       3062.dat ?          0    49662 	   preparado 
   TABLE DATA           W   COPY public.preparado (fk_funcionario_codfuncionario, fk_pedido_codpedido) FROM stdin;
    public          postgres    false    207       3065.dat ?          0    49617    produto 
   TABLE DATA           a   COPY public.produto (codproduto, fk_categoria_codcategoria_pk, estoque, nome, preco) FROM stdin;
    public          postgres    false    202       3060.dat ?          0    49638    telefone 
   TABLE DATA           E   COPY public.telefone (fone, fk_cliente_codcliente, tipo) FROM stdin;
    public          postgres    false    205       3063.dat            0    0    categoria_codcategoria_pk_seq    SEQUENCE SET     K   SELECT pg_catalog.setval('public.categoria_codcategoria_pk_seq', 7, true);
          public          postgres    false    210                    0    0    cliente_codcliente_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('public.cliente_codcliente_seq', 5, true);
          public          postgres    false    209         	           0    0    funcionario_codfuncionario_seq    SEQUENCE SET     L   SELECT pg_catalog.setval('public.funcionario_codfuncionario_seq', 5, true);
          public          postgres    false    211         
           0    0    motoboy_codmotoboy_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('public.motoboy_codmotoboy_seq', 5, true);
          public          postgres    false    212                    0    0    pedido_codpedido_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public.pedido_codpedido_seq', 5, true);
          public          postgres    false    213                    0    0    produto_codproduto_seq    SEQUENCE SET     E   SELECT pg_catalog.setval('public.produto_codproduto_seq', 45, true);
          public          postgres    false    214         f           2606    49655    categoria categoria_pkey 
   CONSTRAINT     c   ALTER TABLE ONLY public.categoria
    ADD CONSTRAINT categoria_pkey PRIMARY KEY (codcategoria_pk);
 B   ALTER TABLE ONLY public.categoria DROP CONSTRAINT categoria_pkey;
       public            postgres    false    206         V           2606    49608 %   cliente cliente_codcliente_rg_cpf_key 
   CONSTRAINT     o   ALTER TABLE ONLY public.cliente
    ADD CONSTRAINT cliente_codcliente_rg_cpf_key UNIQUE (codcliente, rg, cpf);
 O   ALTER TABLE ONLY public.cliente DROP CONSTRAINT cliente_codcliente_rg_cpf_key;
       public            postgres    false    200    200    200         X           2606    49606    cliente cliente_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public.cliente
    ADD CONSTRAINT cliente_pkey PRIMARY KEY (codcliente);
 >   ALTER TABLE ONLY public.cliente DROP CONSTRAINT cliente_pkey;
       public            postgres    false    200         ^           2606    49629    funcionario funcionario_pkey 
   CONSTRAINT     f   ALTER TABLE ONLY public.funcionario
    ADD CONSTRAINT funcionario_pkey PRIMARY KEY (codfuncionario);
 F   ALTER TABLE ONLY public.funcionario DROP CONSTRAINT funcionario_pkey;
       public            postgres    false    203         Z           2606    49616    motoboy motoboy_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public.motoboy
    ADD CONSTRAINT motoboy_pkey PRIMARY KEY (codmotoboy);
 >   ALTER TABLE ONLY public.motoboy DROP CONSTRAINT motoboy_pkey;
       public            postgres    false    201         `           2606    49637    pedido pedido_pkey 
   CONSTRAINT     W   ALTER TABLE ONLY public.pedido
    ADD CONSTRAINT pedido_pkey PRIMARY KEY (codpedido);
 <   ALTER TABLE ONLY public.pedido DROP CONSTRAINT pedido_pkey;
       public            postgres    false    204         \           2606    49621    produto produto_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public.produto
    ADD CONSTRAINT produto_pkey PRIMARY KEY (codproduto);
 >   ALTER TABLE ONLY public.produto DROP CONSTRAINT produto_pkey;
       public            postgres    false    202         b           2606    49647 +   telefone telefone_fk_cliente_codcliente_key 
   CONSTRAINT     w   ALTER TABLE ONLY public.telefone
    ADD CONSTRAINT telefone_fk_cliente_codcliente_key UNIQUE (fk_cliente_codcliente);
 U   ALTER TABLE ONLY public.telefone DROP CONSTRAINT telefone_fk_cliente_codcliente_key;
       public            postgres    false    205         d           2606    49741    telefone telefone_pkey 
   CONSTRAINT     m   ALTER TABLE ONLY public.telefone
    ADD CONSTRAINT telefone_pkey PRIMARY KEY (fk_cliente_codcliente, fone);
 @   ALTER TABLE ONLY public.telefone DROP CONSTRAINT telefone_pkey;
       public            postgres    false    205    205         n           2606    49713    compoe fk_compoe_1    FK CONSTRAINT     ?   ALTER TABLE ONLY public.compoe
    ADD CONSTRAINT fk_compoe_1 FOREIGN KEY (fk_produto_codproduto) REFERENCES public.produto(codproduto) ON DELETE RESTRICT;
 <   ALTER TABLE ONLY public.compoe DROP CONSTRAINT fk_compoe_1;
       public          postgres    false    2908    202    208         o           2606    49718    compoe fk_compoe_2    FK CONSTRAINT     ?   ALTER TABLE ONLY public.compoe
    ADD CONSTRAINT fk_compoe_2 FOREIGN KEY (fk_pedido_codpedido) REFERENCES public.pedido(codpedido) ON DELETE RESTRICT;
 <   ALTER TABLE ONLY public.compoe DROP CONSTRAINT fk_compoe_2;
       public          postgres    false    204    208    2912         h           2606    49673    pedido fk_pedido_2    FK CONSTRAINT     ?   ALTER TABLE ONLY public.pedido
    ADD CONSTRAINT fk_pedido_2 FOREIGN KEY (fk_cliente_codcliente) REFERENCES public.cliente(codcliente) ON DELETE CASCADE;
 <   ALTER TABLE ONLY public.pedido DROP CONSTRAINT fk_pedido_2;
       public          postgres    false    200    204    2904         i           2606    49678    pedido fk_pedido_3    FK CONSTRAINT     ?   ALTER TABLE ONLY public.pedido
    ADD CONSTRAINT fk_pedido_3 FOREIGN KEY (fk_motoboy_codmotoboy) REFERENCES public.motoboy(codmotoboy) ON DELETE CASCADE;
 <   ALTER TABLE ONLY public.pedido DROP CONSTRAINT fk_pedido_3;
       public          postgres    false    204    201    2906         j           2606    49683    pedido fk_pedido_4    FK CONSTRAINT     ?   ALTER TABLE ONLY public.pedido
    ADD CONSTRAINT fk_pedido_4 FOREIGN KEY (fk_funcionario_codfuncionario) REFERENCES public.funcionario(codfuncionario) ON DELETE CASCADE;
 <   ALTER TABLE ONLY public.pedido DROP CONSTRAINT fk_pedido_4;
       public          postgres    false    2910    204    203         l           2606    49703    preparado fk_preparado_1    FK CONSTRAINT     ?   ALTER TABLE ONLY public.preparado
    ADD CONSTRAINT fk_preparado_1 FOREIGN KEY (fk_funcionario_codfuncionario) REFERENCES public.funcionario(codfuncionario) ON DELETE RESTRICT;
 B   ALTER TABLE ONLY public.preparado DROP CONSTRAINT fk_preparado_1;
       public          postgres    false    207    2910    203         m           2606    49708    preparado fk_preparado_2    FK CONSTRAINT     ?   ALTER TABLE ONLY public.preparado
    ADD CONSTRAINT fk_preparado_2 FOREIGN KEY (fk_pedido_codpedido) REFERENCES public.pedido(codpedido) ON DELETE SET NULL;
 B   ALTER TABLE ONLY public.preparado DROP CONSTRAINT fk_preparado_2;
       public          postgres    false    204    207    2912         g           2606    49668    produto fk_produto_2    FK CONSTRAINT     ?   ALTER TABLE ONLY public.produto
    ADD CONSTRAINT fk_produto_2 FOREIGN KEY (fk_categoria_codcategoria_pk) REFERENCES public.categoria(codcategoria_pk);
 >   ALTER TABLE ONLY public.produto DROP CONSTRAINT fk_produto_2;
       public          postgres    false    202    206    2918         k           2606    49688    telefone fk_telefone_2    FK CONSTRAINT     ?   ALTER TABLE ONLY public.telefone
    ADD CONSTRAINT fk_telefone_2 FOREIGN KEY (fk_cliente_codcliente) REFERENCES public.cliente(codcliente);
 @   ALTER TABLE ONLY public.telefone DROP CONSTRAINT fk_telefone_2;
       public          postgres    false    200    205    2904                                                                                                                                                                                                                                                                                                                                                                                            3064.dat                                                                                            0000600 0004000 0002000 00000000101 14045546121 0014240 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        1	Pizza
2	Salgado
3	Acai
4	Sobremesas
5	Sanduiche
6	Bebidas
\.


                                                                                                                                                                                                                                                                                                                                                                                                                                                               3058.dat                                                                                            0000600 0004000 0002000 00000000635 14045546121 0014257 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        1	Joao Barbosa	12345	12345678910	Mandacaru	Beco Ze Borges	50	Bar Ze Pinguco
2	Jose Franca	12346	12345678911	Cruz das Armas	Rua do Rio	100	Padaria dos Sonhos
3	Pedro Calixto	12347	12345678912	Camalau	Rua dos Prazeres	2469	Point das Meninas
4	Isaias Abraao	12348	12345678913	Roger	Rua dos Milagres	33	Igreja da Assembleia Madureira
5	Mohamed Alab	12349	12345678914	Geisel	Rua do Estrondo	50	Central de Policia
\.


                                                                                                   3066.dat                                                                                            0000600 0004000 0002000 00000000005 14045546121 0014245 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        \.


                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           3061.dat                                                                                            0000600 0004000 0002000 00000000277 14045546121 0014253 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        5	Rayme Carvalho	Gerente	3200	\N	\N
4	Flaviano Braga	Cozinheiro	1500	5	\N
3	Guaraci Benito	Servico Gerais	1200	5	\N
2	Jorge Pimentel	Atendente	1200	5	\N
1	Joao Jorge	Atendente	1200	5	\N
\.


                                                                                                                                                                                                                                                                                                                                 3059.dat                                                                                            0000600 0004000 0002000 00000000063 14045546121 0014253 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        1	Jefferson
2	Cachorro_Loko
3	Moleque_du_Grau
\.


                                                                                                                                                                                                                                                                                                                                                                                                                                                                             3062.dat                                                                                            0000600 0004000 0002000 00000000422 14045546121 0014244 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        1	1	1	1	2021-05-08 08:44:54.098736	Em preparo	\N	10
2	2	1	1	2021-05-08 08:49:25.738643	Em preparo	\N	8.00
3	2	2	2	2021-05-08 08:49:25.738643	Em preparo	\N	8.00
4	3	2	2	2021-05-08 08:49:25.738643	Em preparo	\N	20.00
5	5	2	1	2021-05-08 08:49:25.738643	Em preparo	\N	9.00
\.


                                                                                                                                                                                                                                              3065.dat                                                                                            0000600 0004000 0002000 00000000031 14045546121 0014243 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        1	1
1	2
1	3
1	4
1	5
\.


                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       3060.dat                                                                                            0000600 0004000 0002000 00000002333 14045546121 0014245 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        1	1	5	Pizza Mista Pequena	\N
2	1	5	Pizza Mista Média	\N
3	1	5	Pizza Mista Grande	\N
4	1	5	Pizza Mista Familia	\N
5	1	5	Pizza Frango com Catupiry Pequena	\N
6	1	5	Pizza Frango com Catupiry Média	\N
7	1	5	Pizza Frango com Catupiry Grande	\N
8	1	5	Pizza Frango com Catupiry Familia	\N
9	1	5	Pizza Calabresa Pequena	\N
10	1	5	Pizza Calabresa Média	\N
11	1	5	Pizza Calabresa Grande	\N
12	1	5	Pizza Calabresa Familia	\N
13	1	5	Pizza Charque Pequena	\N
14	1	5	Pizza Charque Média	\N
15	1	5	Pizza Charque Grande	\N
16	1	5	Pizza Charque Familia	\N
17	1	5	Pizza A Moda Pequena	\N
18	1	5	Pizza A Moda Média	\N
19	1	5	Pizza A Moda Grande	\N
20	1	5	Pizza A Moda Familia	\N
21	2	5	Coxinha	\N
22	2	5	Enroladinho	\N
23	2	5	Empada	\N
24	2	5	Pastel de Frango	\N
25	2	5	Pastel de Carne	\N
26	2	5	Pastel Misto	\N
27	3	5	Acai no copo	\N
28	3	5	Acai Tigela P	\N
29	3	5	Acai Tigela M	\N
30	3	5	Acai Tigela G	\N
31	3	5	Barca Acai	\N
32	4	5	Torta de chocolate	\N
33	4	5	Bolo no pote	\N
34	4	5	Pudim	\N
35	4	5	Sorvete sabores	\N
36	5	5	Misto quente	\N
37	5	5	Hamburguer tradicional	\N
38	5	5	X-Frango	\N
39	5	5	X-Calabresa	\N
40	5	5	X-Egg	\N
41	5	5	X-Tudo	\N
42	6	15	Agua 500ml	1.5
43	6	25	Coca Cola lata	2.5
44	6	35	Coca Cola 1L	4.5
45	6	50	Guarana lata	2.0
\.


                                                                                                                                                                                                                                                                                                     3063.dat                                                                                            0000600 0004000 0002000 00000000163 14045546121 0014247 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        83988887777	1	Celular
83988887766	2	Celular
83988887755	3	Celular
83988887744	4	Celular
83988887733	5	Celular
\.


                                                                                                                                                                                                                                                                                                                                                                                                             restore.sql                                                                                         0000600 0004000 0002000 00000032315 14045546121 0015372 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        --
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

SET default_tablespace = '';

SET default_table_access_method = heap;

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
-- Name: preparado; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.preparado (
    fk_funcionario_codfuncionario integer,
    fk_pedido_codpedido integer
);


ALTER TABLE public.preparado OWNER TO postgres;

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
COPY public.categoria (codcategoria_pk, categoria) FROM '$$PATH$$/3064.dat';

--
-- Data for Name: cliente; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cliente (codcliente, nome, rg, cpf, bairro, rua, numero, ponto_de_referencia) FROM stdin;
\.
COPY public.cliente (codcliente, nome, rg, cpf, bairro, rua, numero, ponto_de_referencia) FROM '$$PATH$$/3058.dat';

--
-- Data for Name: compoe; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.compoe (fk_produto_codproduto, fk_pedido_codpedido, quantidade) FROM stdin;
\.
COPY public.compoe (fk_produto_codproduto, fk_pedido_codpedido, quantidade) FROM '$$PATH$$/3066.dat';

--
-- Data for Name: funcionario; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.funcionario (codfuncionario, nome, funcao, salario, codgerente, valortotal) FROM stdin;
\.
COPY public.funcionario (codfuncionario, nome, funcao, salario, codgerente, valortotal) FROM '$$PATH$$/3061.dat';

--
-- Data for Name: motoboy; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.motoboy (codmotoboy, nome) FROM stdin;
\.
COPY public.motoboy (codmotoboy, nome) FROM '$$PATH$$/3059.dat';

--
-- Data for Name: pedido; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.pedido (codpedido, fk_cliente_codcliente, fk_motoboy_codmotoboy, fk_funcionario_codfuncionario, data, status, valor, taxa_entrega) FROM stdin;
\.
COPY public.pedido (codpedido, fk_cliente_codcliente, fk_motoboy_codmotoboy, fk_funcionario_codfuncionario, data, status, valor, taxa_entrega) FROM '$$PATH$$/3062.dat';

--
-- Data for Name: preparado; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.preparado (fk_funcionario_codfuncionario, fk_pedido_codpedido) FROM stdin;
\.
COPY public.preparado (fk_funcionario_codfuncionario, fk_pedido_codpedido) FROM '$$PATH$$/3065.dat';

--
-- Data for Name: produto; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.produto (codproduto, fk_categoria_codcategoria_pk, estoque, nome, preco) FROM stdin;
\.
COPY public.produto (codproduto, fk_categoria_codcategoria_pk, estoque, nome, preco) FROM '$$PATH$$/3060.dat';

--
-- Data for Name: telefone; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.telefone (fone, fk_cliente_codcliente, tipo) FROM stdin;
\.
COPY public.telefone (fone, fk_cliente_codcliente, tipo) FROM '$$PATH$$/3063.dat';

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

SELECT pg_catalog.setval('public.pedido_codpedido_seq', 5, true);


--
-- Name: produto_codproduto_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.produto_codproduto_seq', 45, true);


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
-- PostgreSQL database dump complete
--

                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   