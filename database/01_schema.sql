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

-- Prestadores de serviço locais
CREATE TABLE prestador_servico (
    id_prestador   SERIAL       PRIMARY KEY,
    nome           VARCHAR(100) NOT NULL,
    telefone       VARCHAR(20)  NOT NULL,
    especialidade  VARCHAR(100) NOT NULL,
    avaliacao      NUMERIC(2,1) CHECK (avaliacao BETWEEN 0 AND 5)
);

-- Associativa N:N entre serviço e prestador
CREATE TABLE servico_prestador (
    id_servico    INT NOT NULL REFERENCES servico (id_servico) ON DELETE CASCADE,
    id_prestador  INT NOT NULL REFERENCES prestador_servico (id_prestador) ON DELETE CASCADE,
    PRIMARY KEY (id_servico, id_prestador)
);

-- Solicitações abertas pelos moradores
CREATE TABLE solicitacao (
    id_solicitacao  SERIAL      PRIMARY KEY,
    data_abertura   DATE        NOT NULL DEFAULT CURRENT_DATE,
    descricao       TEXT        NOT NULL,
    status          VARCHAR(20) NOT NULL DEFAULT 'ABERTA'
                    CHECK (status IN ('ABERTA', 'EM_ANDAMENTO', 'CONCLUIDA', 'CANCELADA')),
    id_morador      INT         NOT NULL REFERENCES morador (id_morador) ON DELETE RESTRICT,
    id_servico      INT         NOT NULL REFERENCES servico (id_servico) ON DELETE RESTRICT
);

-- Comunicados publicados pela associação
CREATE TABLE comunicacao (
    id_comunicacao  SERIAL       PRIMARY KEY,
    titulo          VARCHAR(100) NOT NULL,
    mensagem        TEXT         NOT NULL,
    data_envio      DATE         NOT NULL DEFAULT CURRENT_DATE,
    id_usuario      INT          NOT NULL REFERENCES usuario (id_usuario) ON DELETE RESTRICT
);

-- Índices para as consultas mais frequentes
CREATE INDEX idx_solicitacao_status  ON solicitacao (status);
CREATE INDEX idx_solicitacao_morador ON solicitacao (id_morador);
CREATE INDEX idx_solicitacao_servico ON solicitacao (id_servico);
CREATE INDEX idx_morador_nome        ON morador (nome);
CREATE INDEX idx_comunicacao_data    ON comunicacao (data_envio DESC);

-- Visão usada no painel: solicitações pendentes
CREATE VIEW vw_solicitacoes_pendentes AS
SELECT s.id_solicitacao, s.data_abertura, m.nome AS morador,
       sv.nome AS servico, s.status
  FROM solicitacao s
  JOIN morador m  ON m.id_morador  = s.id_morador
  JOIN servico sv ON sv.id_servico = s.id_servico
 WHERE s.status IN ('ABERTA', 'EM_ANDAMENTO');

COMMIT;
