-- =====================================================================
-- SAGeC - Script 03: consultas e manipulação de dados
-- =====================================================================
SET search_path TO sagec;

-- C1. Solicitações pendentes com morador e serviço (JOIN)
SELECT s.id_solicitacao AS id, s.data_abertura, m.nome AS morador,
       sv.nome AS servico, s.status
  FROM solicitacao s
  JOIN morador m  ON m.id_morador  = s.id_morador
  JOIN servico sv ON sv.id_servico = s.id_servico
 WHERE s.status IN ('ABERTA', 'EM_ANDAMENTO')
 ORDER BY s.data_abertura;

-- C2. Indicadores do painel: total de solicitações por status
SELECT status, COUNT(*) AS total
  FROM solicitacao
 GROUP BY status
 ORDER BY total DESC;

-- C3. Serviços com mais solicitações e prestadores disponíveis (N:N)
SELECT sv.nome AS servico,
       COUNT(DISTINCT s.id_solicitacao) AS solicitacoes,
       COUNT(DISTINCT sp.id_prestador)  AS prestadores
  FROM servico sv
  LEFT JOIN solicitacao s        ON s.id_servico  = sv.id_servico
  LEFT JOIN servico_prestador sp ON sp.id_servico = sv.id_servico
 GROUP BY sv.nome
 ORDER BY solicitacoes DESC, servico;

-- C4. Prestadores por serviço com avaliação média
SELECT sv.nome AS servico, p.nome AS prestador, p.avaliacao
  FROM servico_prestador sp
  JOIN servico sv          ON sv.id_servico  = sp.id_servico
  JOIN prestador_servico p ON p.id_prestador = sp.id_prestador
 ORDER BY sv.nome, p.avaliacao DESC;

-- C5. Comunicados mais recentes com o autor
SELECT c.data_envio, c.titulo, u.nome AS publicado_por
  FROM comunicacao c
  JOIN usuario u ON u.id_usuario = c.id_usuario
 ORDER BY c.data_envio DESC
 LIMIT 3;

-- M1. Atualização: voluntário inicia o atendimento de uma solicitação
UPDATE solicitacao SET status = 'EM_ANDAMENTO' WHERE id_solicitacao = 4;

-- M2. Remoção lógica: morador que se mudou passa a INATIVO (preserva histórico)
UPDATE morador SET status = 'INATIVO' WHERE cpf = '55588811179';
