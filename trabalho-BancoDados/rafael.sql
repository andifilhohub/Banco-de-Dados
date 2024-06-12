-- Criação da tabela de log
CREATE TABLE registro_auditoria (
    id SERIAL PRIMARY KEY,
    nome_esquema VARCHAR(255),
    nome_tabela VARCHAR(255),
    acao VARCHAR(10),
    data_acao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    id_usuario NAME -- Alteração do tipo de dados para NAME
);

-- Função de gatilho genérica
CREATE OR REPLACE FUNCTION funcao_gatilho_auditoria()
RETURNS TRIGGER AS $$
BEGIN
    IF TG_TABLE_NAME = 'registro_auditoria' THEN
        RETURN NEW; -- Evita a inserção de registros de auditoria para a própria tabela de auditoria
    END IF;
    
    -- Restante da lógica de inserção de registros de auditoria
    IF TG_OP = 'DELETE' THEN
        INSERT INTO registro_auditoria (nome_esquema, nome_tabela, acao, data_acao, id_usuario)
        VALUES (TG_TABLE_SCHEMA, TG_TABLE_NAME, TG_OP, current_timestamp, current_user);
    ELSE
        INSERT INTO registro_auditoria (nome_esquema, nome_tabela, acao,data_acao, id_usuario)
        VALUES (TG_TABLE_SCHEMA, TG_TABLE_NAME, TG_OP, current_timestamp, current_user);
    END IF;
    
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;


-- Criação dos gatilhos para todas as tabelas em todos os esquemas, excluindo visões
DO $$
DECLARE
    esquema_atual RECORD;
    tabela_atual RECORD;
BEGIN
    FOR esquema_atual IN
        SELECT DISTINCT table_schema
        FROM information_schema.tables
        WHERE table_schema NOT IN ('information_schema', 'pg_catalog')
    LOOP
        FOR tabela_atual IN
            SELECT table_name
            FROM information_schema.tables
            WHERE table_schema = esquema_atual.table_schema
            AND table_type = 'BASE TABLE' -- Seleciona apenas tabelas reais, excluindo visões
        LOOP
            EXECUTE format('
                CREATE TRIGGER gatilho_auditoria_%I
                AFTER INSERT OR DELETE OR UPDATE ON %I.%I
                FOR EACH ROW
                EXECUTE FUNCTION funcao_gatilho_auditoria()
            ', tabela_atual.table_name, esquema_atual.table_schema, tabela_atual.table_name);
        END LOOP;
    END LOOP;
END$$;
