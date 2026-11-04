-- =====================================================================
-- SAGeC - Script 02: dados de exemplo (FICTÍCIOS, gerados para testes)
-- Nenhum dado real de morador é utilizado (LGPD).
-- =====================================================================
SET search_path TO sagec;
BEGIN;

INSERT INTO usuario (nome, login, senha_hash, nivel_acesso) VALUES
 ('Administrador do Sistema', 'admin',      '$2b$10$exemploHashBcryptAdmin000000000000000000000000000', 'ADMIN'),
 ('Diretoria (teste)',        'diretoria',  '$2b$10$exemploHashBcryptDiretoria0000000000000000000000', 'DIRETORIA'),
 ('Voluntário (teste)',       'voluntario', '$2b$10$exemploHashBcryptVoluntario000000000000000000000', 'VOLUNTARIO');

INSERT INTO morador (nome, cpf, data_nascimento, telefone, email, logradouro, numero, complemento, status, consentimento_lgpd) VALUES
 ('Ana Souza',        '11144477735', '1985-03-12', '(41) 90000-0001', 'ana.souza@exemplo.com',   'Rua dos Compadres', '120', NULL,      'ATIVO',   TRUE),
 ('Carlos Lima',      '22255588846', '1972-07-25', '(41) 90000-0002', NULL,                      'Rua dos Compadres', '134', 'Fundos', 'ATIVO',   TRUE),
 ('João da Silva',    '33366699957', '1990-11-02', '(41) 90000-0003', 'joao.silva@exemplo.com',  'Rua das Acácias',   '45',  NULL,      'ATIVO',   TRUE),
 ('Maria Oliveira',   '44477700068', '1968-01-30', '(41) 90000-0004', NULL,                      'Rua das Acácias',   '51',  'Casa 2', 'ATIVO',   TRUE),
 ('Paulo Santos',     '55588811179', '2001-09-14', '(41) 90000-0005', 'paulo.santos@exemplo.com','Travessa Favorita', '8',   NULL,      'ATIVO',   FALSE),
 ('Rita Ferreira',    '66699922280', '1979-05-19', '(41) 90000-0006', NULL,                      'Travessa Favorita', '12',  NULL,      'ATIVO',   TRUE),
 ('Sérgio Almeida',   '77700033391', '1958-12-08', '(41) 90000-0007', NULL,                      'Rua Capela Velha',  '300', NULL,      'INATIVO', TRUE),
 ('Tânia Rocha',      '88811144402', '1995-04-03', '(41) 90000-0008', 'tania.rocha@exemplo.com', 'Rua Capela Velha',  '310', 'Ap. 1',  'ATIVO',   TRUE);

INSERT INTO servico (nome, descricao, categoria) VALUES
 ('Iluminação Pública',     'Troca ou reparo de lâmpadas e postes',        'Infraestrutura'),
 ('Coleta de Lixo',         'Problemas na coleta ou descarte irregular',   'Limpeza Urbana'),
 ('Manutenção de Rua',      'Buracos, calçamento e drenagem',              'Infraestrutura'),
 ('Poda de Árvores',        'Poda e remoção de galhos',                    'Meio Ambiente'),
 ('Pequenos Reparos',       'Serviços elétricos e hidráulicos domésticos', 'Serviços Locais');

INSERT INTO prestador_servico (nome, telefone, especialidade, avaliacao) VALUES
 ('Eletricista Bairro Ltda.', '(41) 98000-0001', 'Elétrica',    4.7),
 ('Jardinagem Verde Vida',    '(41) 98000-0002', 'Jardinagem',  4.3),
 ('Reparos & Cia',            '(41) 98000-0003', 'Manutenção',  4.0),
 ('Hidráulica Favorita',      '(41) 98000-0004', 'Hidráulica',  4.9);

INSERT INTO servico_prestador (id_servico, id_prestador) VALUES
 (1, 1), (4, 2), (3, 3), (5, 1), (5, 3), (5, 4);

INSERT INTO solicitacao (data_abertura, descricao, status, id_morador, id_servico) VALUES
 ('2026-10-01', 'Poste apagado em frente ao nº 120',             'CONCLUIDA',    1, 1),
 ('2026-10-05', 'Lixo acumulado na esquina da Travessa Favorita', 'CONCLUIDA',    6, 2),
 ('2026-10-09', 'Buraco grande na Rua das Acácias',              'EM_ANDAMENTO', 3, 3),
 ('2026-10-12', 'Galhos encostando na rede elétrica',            'ABERTA',       4, 4),
 ('2026-10-15', 'Três postes queimados na subida do beco',       'ABERTA',       2, 1),
 ('2026-10-18', 'Vazamento na calçada após chuva',               'EM_ANDAMENTO', 8, 3),
 ('2026-10-21', 'Coleta não passou na quinta-feira',             'ABERTA',       5, 2),
 ('2026-10-24', 'Árvore com risco de queda',                     'ABERTA',       1, 4),
 ('2026-10-27', 'Pedido de reparo elétrico residencial',         'CANCELADA',    3, 5),
 ('2026-10-30', 'Lâmpada piscando na Rua Capela Velha',          'ABERTA',       8, 1);

INSERT INTO comunicacao (titulo, mensagem, data_envio, id_usuario) VALUES
 ('Reunião Ordinária',      'Reunião mensal da associação no sábado, às 15h, na sede.', '2026-10-03', 2),
 ('Campanha de Doação',     'Arrecadação de agasalhos até o fim do mês.',               '2026-10-14', 2),
 ('Mutirão de Limpeza',     'Mutirão de limpeza das calçadas no domingo pela manhã.',   '2026-10-22', 3),
 ('Atualização Cadastral',  'Moradores devem atualizar o cadastro na sede.',            '2026-10-29', 1);

COMMIT;
