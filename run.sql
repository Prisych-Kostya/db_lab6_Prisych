-- Функція
SELECT * FROM get_books_sold_lower_num(80); 

-- Процедура
SELECT * FROM Books;
INSERT INTO
    Books (book_id, book_name, genre, author, lang, publication_date)
VALUES
    ('The Adventures of Pinocchio', 'Childrens fiction', 'Carlo Collodi', 'Italian', 1750),
    ('The Giver', 'Dystopian fiction', 'Lois Lowry', 'English', 1755);

SELECT * FROM Books;
CALL delete_older_books(1755);
SELECT * FROM Books;


-- Тригер
INSERT INTO
    Books (book_id, book_name, genre, author, lang, publication_date)
VALUES
    ('B11', 'The Adventures of Pinocchio', 'Childrens fiction', 'Carlo Collodi', 'Italian', 1750),
    ('B12', 'The Giver', 'Dystopian fiction', 'Lois Lowry', 'English', 1755);
INSERT INTO
	Authors (author_id, author_name, book_id)
VALUES
	('A11', 'Carlo Collodi', 'B11'),
	('A12', 'Lois Lowry', 'B12');
-- Додаємо щось до таблиці Sellings (виконується тригер)
INSERT INTO
   	Sellings (book_id, num_sold)
VALUES
    ('B11', 100),
    ('B12', 150);


-- Змінюємо таблицю Sellings (виконується тригер) 
UPDATE Sellings SET num_sold = 355 WHERE book_id = 'B11';
-- Видаляємо щось із таблиці Sellings (виконується тригер)
DELETE FROM Sellings WHERE book_id in ('B11', 'B12');

SELECT * FROM Sellings_log;