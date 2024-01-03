- Тригер відслідковує модифікацію таблиці Sellings (яка саме була здійснена операція 
-- (INSERT, UPDATE чи DELETE), яким користувачем, та час коли відбулася дана операція) 
-- та заносить інформацію про них в окрему таблицю sellings_log


DROP TABLE IF EXISTS sellings_log;
CREATE TABLE sellings_log(
	id SERIAL PRIMARY KEY,
	change_time TIMESTAMP NOT NULL,
	change_type varchar(20) NOT NULL,
	user_name varchar(50) NOT NULL
);

CREATE OR REPLACE FUNCTION update_sellings_log() RETURNS trigger 
LANGUAGE 'plpgsql'
AS $$
BEGIN
	INSERT INTO sellings_log(change_time, change_type, user_name)
	VALUES(NOW(), 'UPDATE', USER);
	RETURN NULL;
END;
$$;

CREATE OR REPLACE TRIGGER sellings_update 
AFTER UPDATE ON Sellings
FOR EACH ROW EXECUTE FUNCTION update_sellings_log();


CREATE OR REPLACE FUNCTION insert_sellings_log() RETURNS trigger 
LANGUAGE 'plpgsql'
AS $$
BEGIN
	INSERT INTO sellings_log(change_time, change_type, user_name)
	VALUES(NOW(), 'INSERT', USER);
	RETURN NULL;
END;
$$;

CREATE OR REPLACE TRIGGER sellings_insert 
AFTER INSERT ON Sellings
FOR EACH ROW EXECUTE FUNCTION insert_sellings_log();


CREATE OR REPLACE FUNCTION delete_sellings_log() RETURNS trigger 
LANGUAGE 'plpgsql'
AS $$
BEGIN
	INSERT INTO sellings_log(change_time, change_type, user_name)
	VALUES(NOW(), 'DELETE', USER);
	RETURN NULL;
END;
$$;

CREATE OR REPLACE TRIGGER sellings_delete 
AFTER DELETE ON Sellings
FOR EACH ROW EXECUTE FUNCTION delete_sellings_log();

