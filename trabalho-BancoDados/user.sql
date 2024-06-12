-- criando usuarios:
CREATE USER vitor WITH PASSWORD '3579'; 
CREATE USER joao WITH PASSWORD '2468';
CREATE USER maria WITH PASSWORD '123456';

-- remover usuarios:
DROP USER <nome_usuário>;

-- alterar o nome de um usuario:
ALTER USER nome RENAME TO <novo_nome>;

-- criando grupos:
CREATE GROUP Estagiarios;
CREATE GROUP Analistas;
CREATE GROUP Gerentes;

-- Políticas de acesso para o grupo Estagiarios:
-- Esse grupo pode apenas visualizar informações (apenas comandos SELECT).
--  implementando as políticas de acesso:
GRANT SELECT ON ALL TABLES IN SCHEMA hr TO Estagiarios;
GRANT SELECT ON ALL TABLES IN SCHEMA humanresources TO Estagiarios;
GRANT SELECT ON ALL TABLES IN SCHEMA pe TO Estagiarios;
GRANT SELECT ON ALL TABLES IN SCHEMA person TO Estagiarios;
GRANT SELECT ON ALL TABLES IN SCHEMA pr TO Estagiarios;
GRANT SELECT ON ALL TABLES IN SCHEMA production TO Estagiarios;
GRANT SELECT ON ALL TABLES IN SCHEMA pu TO Estagiarios;
GRANT SELECT ON ALL TABLES IN SCHEMA public TO Estagiarios;
GRANT SELECT ON ALL TABLES IN SCHEMA purchasing TO Estagiarios;
GRANT SELECT ON ALL TABLES IN SCHEMA sa TO Estagiarios;
GRANT SELECT ON ALL TABLES IN SCHEMA sales TO Estagiarios;

-- Políticas de acesso para o grupo Analistas:
-- Esse grupo possui permissão de modificar registros, mas não pode 
-- acessar nenhuma rotina, não pode criar base de dados e não pode criar tabelas.

--  implementando as políticas de acesso:
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA hr TO Analistas;
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA humanresources TO Analistas;
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA pe TO Analistas;
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA person TO Analistas;
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA pr TO Analistas;
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA production TO Analistas;
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA pu TO Analistas;
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA public TO Analistas;
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA purchasing TO Analistas;
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA sa TO Analistas;
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA sales TO Analistas;

-- negar a capacidade de criar bancos de dados e tabelas:
ALTER ROLE Analistas NOCREATEDB;
-- tirando superusuario:
ALTER ROLE Analistas NOSUPERUSER;
-- verificando os nomes das bases de dados existentes:
SELECT datname FROM pg_database;
-- negar a capacidade de criar tabelas:
REVOKE CREATE ON SCHEMA hr FROM Analistas;
REVOKE CREATE ON SCHEMA humanresources FROM Analistas;
REVOKE CREATE ON SCHEMA pe FROM Analistas;
REVOKE CREATE ON SCHEMA person FROM Analistas;
REVOKE CREATE ON SCHEMA pr FROM Analistas;
REVOKE CREATE ON SCHEMA production FROM Analistas;
REVOKE CREATE ON SCHEMA pu FROM Analistas;
REVOKE CREATE ON SCHEMA public FROM Analistas;
REVOKE CREATE ON SCHEMA purchasing FROM Analistas;
REVOKE CREATE ON SCHEMA sa FROM Analistas;
REVOKE CREATE ON SCHEMA sales FROM Analistas;

-- negar o acesso a rotinas:

REVOKE EXECUTE ON ALL FUNCTIONS IN SCHEMA hr FROM Analistas;
REVOKE EXECUTE ON ALL FUNCTIONS IN SCHEMA humanresources FROM Analistas;
REVOKE EXECUTE ON ALL FUNCTIONS IN SCHEMA pe FROM Analistas;
REVOKE EXECUTE ON ALL FUNCTIONS IN SCHEMA person FROM Analistas;
REVOKE EXECUTE ON ALL FUNCTIONS IN SCHEMA pr FROM Analistas;
REVOKE EXECUTE ON ALL FUNCTIONS IN SCHEMA production FROM Analistas;
REVOKE EXECUTE ON ALL FUNCTIONS IN SCHEMA public FROM Analistas;
REVOKE EXECUTE ON ALL FUNCTIONS IN SCHEMA purchasing FROM Analistas;
REVOKE EXECUTE ON ALL FUNCTIONS IN SCHEMA sa FROM Analistas;
REVOKE EXECUTE ON ALL FUNCTIONS IN SCHEMA sales FROM Analistas;

-- Políticas de acesso para o grupo Gerentes:
-- Esse grupo de usuário tem a permissão de modificar todos os registros de 
-- todas as tabelas, além de utilizar as rotinas (stored procedures), além de 
-- poder dar direitos aos outros usuários

--  implementando as políticas de acesso:
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA hr TO Gerentes;
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA humanresources TO Gerentes;
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA pe TO Gerentes;
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA person TO Gerentes;
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA pr TO Gerentes;
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA production TO Gerentes;
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA pu TO Gerentes;
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA public TO Gerentes;
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA purchasing TO Gerentes;
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA sa TO Gerentes;
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA sales TO Gerentes;

-- conceder permissão para modificar todos os registros de todas as tabelas e usar rotinas

GRANT USAGE ON SCHEMA hr TO Gerentes;
GRANT USAGE ON SCHEMA humanresources TO Gerentes;
GRANT USAGE ON SCHEMA pe TO Gerentes;
GRANT USAGE ON SCHEMA person TO Gerentes;
GRANT USAGE ON SCHEMA pr TO Gerentes;
GRANT USAGE ON SCHEMA production TO Gerentes;
GRANT USAGE ON SCHEMA pu TO Gerentes;
GRANT USAGE ON SCHEMA public TO Gerentes;
GRANT USAGE ON SCHEMA purchasing TO Gerentes;
GRANT USAGE ON SCHEMA sa TO Gerentes;
GRANT USAGE ON SCHEMA sales TO Gerentes;

GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA hr TO Gerentes;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA humanresources TO Gerentes;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA pe TO Gerentes;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA person TO Gerentes;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA pr TO Gerentes;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA production TO Gerentes;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA pu TO Gerentes;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO Gerentes;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA purchasing TO Gerentes;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA sa TO Gerentes;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA sales TO Gerentes;


GRANT EXECUTE ON ALL FUNCTIONS IN SCHEMA hr TO Gerentes;
GRANT EXECUTE ON ALL FUNCTIONS IN SCHEMA humanresources TO Gerentes;
GRANT EXECUTE ON ALL FUNCTIONS IN SCHEMA pe TO Gerentes;
GRANT EXECUTE ON ALL FUNCTIONS IN SCHEMA person TO Gerentes;
GRANT EXECUTE ON ALL FUNCTIONS IN SCHEMA pr TO Gerentes;
GRANT EXECUTE ON ALL FUNCTIONS IN SCHEMA production TO Gerentes;
GRANT EXECUTE ON ALL FUNCTIONS IN SCHEMA pu TO Gerentes;
GRANT EXECUTE ON ALL FUNCTIONS IN SCHEMA public TO Gerentes;
GRANT EXECUTE ON ALL FUNCTIONS IN SCHEMA purchasing TO Gerentes;
GRANT EXECUTE ON ALL FUNCTIONS IN SCHEMA sa TO Gerentes;
GRANT EXECUTE ON ALL FUNCTIONS IN SCHEMA sales TO Gerentes;

-- garantir pagar grupos
GRANT DROP ON GROUP Estagiarios TO Gerentes;
GRANT DROP ON GROUP Analistas TO Gerentes;

-- garantir deletar usuarios
GRANT DROP ROLE TO Gerentes;

-- permitir que o usuário conceda direitos a outros usuários

GRANT CREATE ON SCHEMA <nome_schema> TO <nome_usuario_conceder_direitos>;

-- Adicionando usuários aos grupos
ALTER GROUP Estagiarios ADD USER vitor;
ALTER GROUP Analistas ADD USER joao;
ALTER GROUP Gerentes ADD USER maria;


-- remover usuarios em um grupo
ALTER GROUP <nome_do_grupo> DROP USER <nome_do_usuário>;

-- remover um grupo
DROP GROUP <nome_do_grupo>;

-- mudar nome de um grupo
ALTER GROUP <nome_do_grupo> RENAME TO <novo_nome>;

