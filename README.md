# SAGeC - Sistema de Apoio à Gestão e Comunicação

Sistema web para a Associação de Moradores da Comunidade Favorita (Araucária-PR),
desenvolvido no Projeto Integrador II (UFMS Digital).

## Estrutura
- `database/` scripts SQL do banco de dados PostgreSQL
- `docs/` diagramas e documentação

## Como executar o banco de dados
```bash
cp .env.example .env
docker compose up -d
```
Os scripts de `database/` são executados automaticamente na primeira inicialização,
em ordem alfabética (01 esquema, 02 dados fictícios, 03 consultas, 04 testes de restrição).
Para repetir as consultas de exemplo:
```bash
docker compose exec db psql -U sagec -d sagec -f /docker-entrypoint-initdb.d/03_consultas.sql
```

## Fluxo de trabalho Git
- `main`: versão estável (somente via pull request de `develop`, com tag de versão)
- `develop`: integração das funcionalidades
- `feature/<nome>`: uma branch por funcionalidade, criada a partir de `develop`
- Commits no padrão Conventional Commits (`feat:`, `fix:`, `docs:`, `test:`, `chore:`)

## Dados
Todos os dados de `02_seed.sql` são fictícios. Nenhum dado real de morador deve ser
versionado no repositório (LGPD).
