-- Session #1
BEGIN TRANSACTION ISOLATION LEVEL READ COMMITTED;
-- Session #2
BEGIN TRANSACTION ISOLATION LEVEL READ COMMITTED;
-- Session #1
SHOW TRANSACTION ISOLATION LEVEL;
-- Session #2
SHOW TRANSACTION ISOLATION LEVEL;
-- Session #1
SELECT SUM(rating) FROM pizzeria;
-- Session #2
INSERT INTO pizzeria
-- Session #2
VALUES (10, 'Kazan Pizza', 5);
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