--
-- PostgreSQL database dump
--

-- Dumped from database version 13.1
-- Dumped by pg_dump version 13.2

-- Started on 2021-05-08 14:24:02

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
-- TOC entry 206 (class 1259 OID 49648)
-- Name: categoria; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.categoria (
    codcategoria_pk integer NOT NULL,
    categoria character varying
);


ALTER TABLE public.categoria OWNER TO postgres;

--
-- TOC entry 210 (class 1259 OID 49730)
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
-- TOC entry 200 (class 1259 OID 49599)
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
-- TOC entry 209 (class 1259 OID 49728)
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
-- TOC entry 208 (class 1259 OID 49665)
-- Name: compoe; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.compoe (
    fk_produto_codproduto integer NOT NULL,
    fk_pedido_codpedido integer NOT NULL,
    quantidade integer NOT NULL
);


ALTER TABLE public.compoe OWNER TO postgres;

--
-- TOC entry 203 (class 1259 OID 49622)
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
-- TOC entry 211 (class 1259 OID 49732)
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
-- TOC entry 201 (class 1259 OID 49609)
-- Name: motoboy; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.motoboy (
    codmotoboy integer NOT NULL,
    nome character varying NOT NULL
);


ALTER TABLE public.motoboy OWNER TO postgres;

--
-- TOC entry 212 (class 1259 OID 49734)
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
-- TOC entry 204 (class 1259 OID 49630)
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
-- TOC entry 213 (class 1259 OID 49736)
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
-- TOC entry 207 (class 1259 OID 49662)
-- Name: preparado; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.preparado (
    fk_funcionario_codfuncionario integer,
    fk_pedido_codpedido integer
);


ALTER TABLE public.preparado OWNER TO postgres;

--
-- TOC entry 202 (class 1259 OID 49617)
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
-- TOC entry 214 (class 1259 OID 49738)
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
-- TOC entry 205 (class 1259 OID 49638)
-- Name: telefone; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.telefone (
    fone character varying NOT NULL,
    fk_cliente_codcliente integer NOT NULL,
    tipo character varying
);


ALTER TABLE public.telefone OWNER TO postgres;

--
-- TOC entry 3064 (class 0 OID 49648)
-- Dependencies: 206
-- Data for Name: categoria; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.categoria (codcategoria_pk, categoria) FROM stdin;
1	Pizza
2	Salgado
3	Acai
4	Sobremesas
5	Sanduiche
6	Bebidas
\.


--
-- TOC entry 3058 (class 0 OID 49599)
-- Dependencies: 200
-- Data for Name: cliente; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cliente (codcliente, nome, rg, cpf, bairro, rua, numero, ponto_de_referencia) FROM stdin;
1	Joao Barbosa	12345	12345678910	Mandacaru	Beco Ze Borges	50	Bar Ze Pinguco
2	Jose Franca	12346	12345678911	Cruz das Armas	Rua do Rio	100	Padaria dos Sonhos
3	Pedro Calixto	12347	12345678912	Camalau	Rua dos Prazeres	2469	Point das Meninas
4	Isaias Abraao	12348	12345678913	Roger	Rua dos Milagres	33	Igreja da Assembleia Madureira
5	Mohamed Alab	12349	12345678914	Geisel	Rua do Estrondo	50	Central de Policia
\.


--
-- TOC entry 3066 (class 0 OID 49665)
-- Dependencies: 208
-- Data for Name: compoe; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.compoe (fk_produto_codproduto, fk_pedido_codpedido, quantidade) FROM stdin;
\.


--
-- TOC entry 3061 (class 0 OID 49622)
-- Dependencies: 203
-- Data for Name: funcionario; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.funcionario (codfuncionario, nome, funcao, salario, codgerente, valortotal) FROM stdin;
5	Rayme Carvalho	Gerente	3200	\N	\N
4	Flaviano Braga	Cozinheiro	1500	5	\N
3	Guaraci Benito	Servico Gerais	1200	5	\N
2	Jorge Pimentel	Atendente	1200	5	\N
1	Joao Jorge	Atendente	1200	5	\N
\.


--
-- TOC entry 3059 (class 0 OID 49609)
-- Dependencies: 201
-- Data for Name: motoboy; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.motoboy (codmotoboy, nome) FROM stdin;
1	Jefferson
2	Cachorro_Loko
3	Moleque_du_Grau
\.


--
-- TOC entry 3062 (class 0 OID 49630)
-- Dependencies: 204
-- Data for Name: pedido; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.pedido (codpedido, fk_cliente_codcliente, fk_motoboy_codmotoboy, fk_funcionario_codfuncionario, data, status, valor, taxa_entrega) FROM stdin;
1	1	1	1	2021-05-08 08:44:54.098736	Em preparo	\N	10
2	2	1	1	2021-05-08 08:49:25.738643	Em preparo	\N	8.00
3	2	2	2	2021-05-08 08:49:25.738643	Em preparo	\N	8.00
4	3	2	2	2021-05-08 08:49:25.738643	Em preparo	\N	20.00
5	5	2	1	2021-05-08 08:49:25.738643	Em preparo	\N	9.00
\.


--
-- TOC entry 3065 (class 0 OID 49662)
-- Dependencies: 207
-- Data for Name: preparado; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.preparado (fk_funcionario_codfuncionario, fk_pedido_codpedido) FROM stdin;
1	1
1	2
1	3
1	4
1	5
\.


--
-- TOC entry 3060 (class 0 OID 49617)
-- Dependencies: 202
-- Data for Name: produto; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.produto (codproduto, fk_categoria_codcategoria_pk, estoque, nome, preco) FROM stdin;
1	1	5	Pizza Mista Pequena	\N
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


--
-- TOC entry 3063 (class 0 OID 49638)
-- Dependencies: 205
-- Data for Name: telefone; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.telefone (fone, fk_cliente_codcliente, tipo) FROM stdin;
83988887777	1	Celular
83988887766	2	Celular
83988887755	3	Celular
83988887744	4	Celular
83988887733	5	Celular
\.


--
-- TOC entry 3078 (class 0 OID 0)
-- Dependencies: 210
-- Name: categoria_codcategoria_pk_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.categoria_codcategoria_pk_seq', 7, true);


--
-- TOC entry 3079 (class 0 OID 0)
-- Dependencies: 209
-- Name: cliente_codcliente_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.cliente_codcliente_seq', 5, true);


--
-- TOC entry 3080 (class 0 OID 0)
-- Dependencies: 211
-- Name: funcionario_codfuncionario_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.funcionario_codfuncionario_seq', 5, true);


--
-- TOC entry 3081 (class 0 OID 0)
-- Dependencies: 212
-- Name: motoboy_codmotoboy_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.motoboy_codmotoboy_seq', 5, true);


--
-- TOC entry 3082 (class 0 OID 0)
-- Dependencies: 213
-- Name: pedido_codpedido_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.pedido_codpedido_seq', 5, true);


--
-- TOC entry 3083 (class 0 OID 0)
-- Dependencies: 214
-- Name: produto_codproduto_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.produto_codproduto_seq', 45, true);


--
-- TOC entry 2918 (class 2606 OID 49655)
-- Name: categoria categoria_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categoria
    ADD CONSTRAINT categoria_pkey PRIMARY KEY (codcategoria_pk);


--
-- TOC entry 2902 (class 2606 OID 49608)
-- Name: cliente cliente_codcliente_rg_cpf_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cliente
    ADD CONSTRAINT cliente_codcliente_rg_cpf_key UNIQUE (codcliente, rg, cpf);


--
-- TOC entry 2904 (class 2606 OID 49606)
-- Name: cliente cliente_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cliente
    ADD CONSTRAINT cliente_pkey PRIMARY KEY (codcliente);


--
-- TOC entry 2910 (class 2606 OID 49629)
-- Name: funcionario funcionario_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.funcionario
    ADD CONSTRAINT funcionario_pkey PRIMARY KEY (codfuncionario);


--
-- TOC entry 2906 (class 2606 OID 49616)
-- Name: motoboy motoboy_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.motoboy
    ADD CONSTRAINT motoboy_pkey PRIMARY KEY (codmotoboy);


--
-- TOC entry 2912 (class 2606 OID 49637)
-- Name: pedido pedido_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pedido
    ADD CONSTRAINT pedido_pkey PRIMARY KEY (codpedido);


--
-- TOC entry 2908 (class 2606 OID 49621)
-- Name: produto produto_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.produto
    ADD CONSTRAINT produto_pkey PRIMARY KEY (codproduto);


--
-- TOC entry 2914 (class 2606 OID 49647)
-- Name: telefone telefone_fk_cliente_codcliente_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.telefone
    ADD CONSTRAINT telefone_fk_cliente_codcliente_key UNIQUE (fk_cliente_codcliente);


--
-- TOC entry 2916 (class 2606 OID 49741)
-- Name: telefone telefone_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.telefone
    ADD CONSTRAINT telefone_pkey PRIMARY KEY (fk_cliente_codcliente, fone);


--
-- TOC entry 2926 (class 2606 OID 49713)
-- Name: compoe fk_compoe_1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.compoe
    ADD CONSTRAINT fk_compoe_1 FOREIGN KEY (fk_produto_codproduto) REFERENCES public.produto(codproduto) ON DELETE RESTRICT;


--
-- TOC entry 2927 (class 2606 OID 49718)
-- Name: compoe fk_compoe_2; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.compoe
    ADD CONSTRAINT fk_compoe_2 FOREIGN KEY (fk_pedido_codpedido) REFERENCES public.pedido(codpedido) ON DELETE RESTRICT;


--
-- TOC entry 2920 (class 2606 OID 49673)
-- Name: pedido fk_pedido_2; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pedido
    ADD CONSTRAINT fk_pedido_2 FOREIGN KEY (fk_cliente_codcliente) REFERENCES public.cliente(codcliente) ON DELETE CASCADE;


--
-- TOC entry 2921 (class 2606 OID 49678)
-- Name: pedido fk_pedido_3; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pedido
    ADD CONSTRAINT fk_pedido_3 FOREIGN KEY (fk_motoboy_codmotoboy) REFERENCES public.motoboy(codmotoboy) ON DELETE CASCADE;


--
-- TOC entry 2922 (class 2606 OID 49683)
-- Name: pedido fk_pedido_4; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pedido
    ADD CONSTRAINT fk_pedido_4 FOREIGN KEY (fk_funcionario_codfuncionario) REFERENCES public.funcionario(codfuncionario) ON DELETE CASCADE;


--
-- TOC entry 2924 (class 2606 OID 49703)
-- Name: preparado fk_preparado_1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.preparado
    ADD CONSTRAINT fk_preparado_1 FOREIGN KEY (fk_funcionario_codfuncionario) REFERENCES public.funcionario(codfuncionario) ON DELETE RESTRICT;


--
-- TOC entry 2925 (class 2606 OID 49708)
-- Name: preparado fk_preparado_2; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.preparado
    ADD CONSTRAINT fk_preparado_2 FOREIGN KEY (fk_pedido_codpedido) REFERENCES public.pedido(codpedido) ON DELETE SET NULL;


--
-- TOC entry 2919 (class 2606 OID 49668)
-- Name: produto fk_produto_2; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.produto
    ADD CONSTRAINT fk_produto_2 FOREIGN KEY (fk_categoria_codcategoria_pk) REFERENCES public.categoria(codcategoria_pk);


--
-- TOC entry 2923 (class 2606 OID 49688)
-- Name: telefone fk_telefone_2; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.telefone
    ADD CONSTRAINT fk_telefone_2 FOREIGN KEY (fk_cliente_codcliente) REFERENCES public.cliente(codcliente);


-- Completed on 2021-05-08 14:24:02

--
-- PostgreSQL database dump complete
--

