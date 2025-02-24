WITH all_orders AS (
	SELECT DISTINCT pz.name AS pizzeria_name, p.gender
	FROM pizzeria pz
	JOIN menu m ON pz.id = m.pizzeria_id
	JOIN person_order po ON m.id = po.menu_id
	JOIN person p ON po.person_id = p.id
)
SELECT pizzeria_name
FROM all_orders
WHERE gender = 'female'
AND pizzeria_name NOT IN (
	SELECT pizzeria_name
	FROM all_orders
	WHERE gender = 'male'
)
UNION
SELECT pizzeria_name
FROM all_orders
WHERE gender = 'male'
AND pizzeria_name NOT IN (
	SELECT pizzeria_name
	FROM all_orders
	WHERE gender = 'female'
)
ORDER BY pizzeria_name;