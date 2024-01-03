-- Процедура видаляє з таблиці книги,
-- рік публікації яких менше або рівне заданої (year)

DROP PROCEDURE IF EXISTS delete_older_books(integer); 
 
CREATE OR REPLACE PROCEDURE delete_older_books(received_year integer)
LANGUAGE plpgsql 
AS $$ 
BEGIN 
	DELETE FROM Authors 
    WHERE book_id IN (SELECT book_id FROM Books WHERE publication_date <= received_year);
	
    DELETE FROM Sellings 
    WHERE book_id IN (SELECT book_id FROM Books WHERE publication_date <= received_year);

    DELETE FROM Books 
    WHERE publication_date <= received_year;
END; 
$$;