-- =====================================================================
-- SAGeC - Sistema de Apoio à Gestão e Comunicação
-- Script 01: criação do esquema (PostgreSQL 16)
-- =====================================================================
BEGIN;

DROP SCHEMA IF EXISTS sagec CASCADE;
CREATE SCHEMA sagec;
SET search_path TO sagec;

-- Usuários do sistema (diretoria e voluntários)
CREATE TABLE usuario (
    id_usuario    SERIAL       PRIMARY KEY,
    nome          VARCHAR(100) NOT NULL,
    login         VARCHAR(50)  NOT NULL UNIQUE,
    senha_hash    VARCHAR(255) NOT NULL,
    nivel_acesso  VARCHAR(20)  NOT NULL DEFAULT 'VOLUNTARIO'
                  CHECK (nivel_acesso IN ('ADMIN', 'DIRETORIA', 'VOLUNTARIO')),
    ativo         BOOLEAN      NOT NULL DEFAULT TRUE,
    criado_em     TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Moradores cadastrados pela associação
CREATE TABLE morador (
    id_morador        SERIAL       PRIMARY KEY,
    nome              VARCHAR(100) NOT NULL,
    cpf               CHAR(11)     NOT NULL UNIQUE CHECK (cpf ~ '^[0-9]{11}$'),
    data_nascimento   DATE         CHECK (data_nascimento <= CURRENT_DATE),
    telefone          VARCHAR(20),
    email             VARCHAR(100),
    logradouro        VARCHAR(120) NOT NULL,
    numero            VARCHAR(10)  NOT NULL,
    complemento       VARCHAR(60),
    status            VARCHAR(20)  NOT NULL DEFAULT 'ATIVO'
                      CHECK (status IN ('ATIVO', 'INATIVO')),
    consentimento_lgpd BOOLEAN     NOT NULL DEFAULT FALSE,
    criado_em         TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Serviços oferecidos ou demandados na comunidade
CREATE TABLE servico (
    id_servico  SERIAL       PRIMARY KEY,
    nome        VARCHAR(100) NOT NULL UNIQUE,
    descricao   TEXT,
    categoria   VARCHAR(50)  NOT NULL,
    status      VARCHAR(20)  NOT NULL DEFAULT 'ATIVO'
                CHECK (status IN ('ATIVO', 'INATIVO'))
);

COMMIT;
