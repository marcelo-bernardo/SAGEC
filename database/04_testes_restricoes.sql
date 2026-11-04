-- =====================================================================
-- SAGeC - Script 04: verificação das restrições de integridade
-- Cada comando abaixo DEVE falhar.
-- =====================================================================
SET search_path TO sagec;
\set ON_ERROR_STOP off

-- CPF duplicado (UNIQUE)
INSERT INTO morador (nome, cpf, logradouro, numero) VALUES ('Teste', '11144477735', 'Rua X', '1');
-- Status inválido (CHECK)
INSERT INTO solicitacao (descricao, status, id_morador, id_servico) VALUES ('Teste', 'PENDENTE', 1, 1);
-- Morador inexistente (FOREIGN KEY)
INSERT INTO solicitacao (descricao, id_morador, id_servico) VALUES ('Teste', 999, 1);
-- Excluir morador que possui solicitações (ON DELETE RESTRICT)
DELETE FROM morador WHERE id_morador = 1;
