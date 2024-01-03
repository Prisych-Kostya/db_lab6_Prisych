-- Функція повертає таблицю з назвами та id книг, а також кількість проданих кних, 
-- якщо їх було продано не менше вказаної кількості (received_num)

DROP FUNCTION IF EXISTS get_books_sold_lower_num(integer);  
 
CREATE OR REPLACE FUNCTION get_books_sold_lower_num(received_num integer)  
    RETURNS TABLE (book_id varchar, book_name varchar, num_sold integer) 
LANGUAGE plpgsql 
AS $$
BEGIN 
    RETURN QUERY 
   		SELECT 
			Books.book_id::varchar, Books.book_name::varchar, Sellings.num_sold::integer
		FROM 
			Books
		JOIN 
			Sellings ON Books.book_id = Sellings.book_id
		WHERE 
			Sellings.num_sold >= received_num;
END;
$$;

