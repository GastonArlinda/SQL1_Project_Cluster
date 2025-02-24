CREATE VIEW v_price_with_discount AS (
	SELECT p.name, m.pizza_name, m.price, CAST(m.price * 0.9 AS INTEGER) AS discount_price
	FROM person_order po
	JOIN menu m ON po.menu_id = m.id
	JOIN person p ON po.person_id = p.id
	ORDER BY p.name, m.pizza_name
);