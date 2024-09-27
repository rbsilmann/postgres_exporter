ALTER SYSTEM SET shared_preload_libraries = 'pg_stat_statements';

-- Reinicie o PostgreSQL

-- Conecte no banco e habilite a extensão

CREATE EXTENSION pg_stat_statements;

-- Verifique se foi habilitada

SELECT * FROM pg_stat_statements LIMIT 10;

-- Crie o usuário não root pro pg_exporter e conceda a permissão necessária

CREATE USER exporter_user WITH PASSWORD 'senha_segura';
GRANT pg_monitor TO exporter_user;

