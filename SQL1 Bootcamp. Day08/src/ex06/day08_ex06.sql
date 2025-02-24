-- Session #1
BEGIN TRANSACTION ISOLATION LEVEL REPEATABLE READ;
-- Session #2
BEGIN TRANSACTION ISOLATION LEVEL REPEATABLE READ;
-- Session #1
SHOW TRANSACTION ISOLATION LEVEL;
-- Session #2
SHOW TRANSACTION ISOLATION LEVEL;
-- Session #1
SELECT SUM(rating) FROM pizzeria;
-- Session #2
INSERT INTO pizzeria
VALUES (11, 'Kazan Pizza 2', 4);
-- Session #2
COMMIT;
-- Session #1
SELECT SUM(rating) FROM pizzeria;
-- Session #1
COMMIT;
-- Session #1
SELECT SUM(rating) FROM pizzeria;
-- Session #2
SELECT SUM(rating) FROM pizzeria;