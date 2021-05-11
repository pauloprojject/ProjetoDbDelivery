CREATE DATABASE delivery


CREATE TABLE public.funcionario
(
    codfuncionario integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    nome character varying COLLATE pg_catalog."default",
    funcao character varying COLLATE pg_catalog."default",
    salario numeric,
    codgerente integer,
    CONSTRAINT funcionario_pkey PRIMARY KEY (codfuncionario),
    CONSTRAINT salariopositivo CHECK (salario > 0::numeric)
);


CREATE TABLE public.cliente
(
    codcliente integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    nome character varying COLLATE pg_catalog."default",
    rg integer,
    cpf character varying COLLATE pg_catalog."default",
    bairro character varying COLLATE pg_catalog."default",
    rua character varying COLLATE pg_catalog."default",
    numero integer,
    ponto_de_referencia character varying COLLATE pg_catalog."default",
    CONSTRAINT cliente_pkey PRIMARY KEY (codcliente),
    CONSTRAINT cliente_codcliente_rg_cpf_key UNIQUE (codcliente, rg, cpf),
    CONSTRAINT tamanhocpf CHECK (length(cpf::text) = 11)
);


CREATE TABLE public.telefone
(
    fone character varying COLLATE pg_catalog."default" NOT NULL,
    fk_cliente_codcliente integer NOT NULL,
    tipo character varying COLLATE pg_catalog."default",
    CONSTRAINT telefone_pkey PRIMARY KEY (fk_cliente_codcliente, fone),
    CONSTRAINT telefone_fk_cliente_codcliente_key UNIQUE (fk_cliente_codcliente),
    CONSTRAINT fk_telefone_2 FOREIGN KEY (fk_cliente_codcliente)
        REFERENCES public.cliente (codcliente) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);


CREATE TABLE public.motoboy
(
    codmotoboy integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    nome character varying COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT motoboy_pkey PRIMARY KEY (codmotoboy)
);

CREATE TABLE public.categoria
(
    codcategoria_pk integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    categoria character varying COLLATE pg_catalog."default",
    CONSTRAINT categoria_pkey PRIMARY KEY (codcategoria_pk)
);

CREATE TABLE public.produto
(
    codproduto integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    fk_categoria_codcategoria_pk integer,
    estoque integer,
    nome character varying(60) COLLATE pg_catalog."default",
    preco numeric,
    CONSTRAINT produto_pkey PRIMARY KEY (codproduto),
    CONSTRAINT fk_produto_2 FOREIGN KEY (fk_categoria_codcategoria_pk)
        REFERENCES public.categoria (codcategoria_pk) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);

CREATE TABLE public.pedido
(
    codpedido integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    fk_cliente_codcliente integer,
    fk_motoboy_codmotoboy integer,
    fk_funcionario_codfuncionario integer,
    data timestamp without time zone,
    status character varying COLLATE pg_catalog."default",
    valor numeric,
    taxa_entrega numeric,
    CONSTRAINT pedido_pkey PRIMARY KEY (codpedido),
    CONSTRAINT fk_pedido_2 FOREIGN KEY (fk_cliente_codcliente)
        REFERENCES public.cliente (codcliente) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE CASCADE,
    CONSTRAINT fk_pedido_3 FOREIGN KEY (fk_motoboy_codmotoboy)
        REFERENCES public.motoboy (codmotoboy) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE CASCADE,
    CONSTRAINT fk_pedido_4 FOREIGN KEY (fk_funcionario_codfuncionario)
        REFERENCES public.funcionario (codfuncionario) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE CASCADE
);

CREATE TABLE public.compoe
(
    fk_produto_codproduto integer NOT NULL,
    fk_pedido_codpedido integer NOT NULL,
    quantidade integer NOT NULL,
    CONSTRAINT fk_compoe_1 FOREIGN KEY (fk_produto_codproduto)
        REFERENCES public.produto (codproduto) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE RESTRICT,
    CONSTRAINT fk_compoe_2 FOREIGN KEY (fk_pedido_codpedido)
        REFERENCES public.pedido (codpedido) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE RESTRICT
);

CREATE TABLE public.preparado
(
    fk_funcionario_codfuncionario integer,
    fk_pedido_codpedido integer,
    CONSTRAINT fk_preparado_1 FOREIGN KEY (fk_funcionario_codfuncionario)
        REFERENCES public.funcionario (codfuncionario) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE RESTRICT,
    CONSTRAINT fk_preparado_2 FOREIGN KEY (fk_pedido_codpedido)
        REFERENCES public.pedido (codpedido) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE SET NULL
);