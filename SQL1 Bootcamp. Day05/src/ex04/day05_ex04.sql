CREATE INDEX idx_menu_unique ON menu(pizzeria_id, pizza_name);

SET enable_seqscan TO OFF;
EXPLAIN ANALYZE
	SELECT pizzeria_id, pizza_name
	FROM menu
	WHERE pizzeria_id = 1 AND pizza_name = 'sicilian pizza';