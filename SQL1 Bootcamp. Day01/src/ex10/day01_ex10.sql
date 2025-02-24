SELECT
	p.name AS person_name,
	m.pizza_name AS pizza_name,
	pz.name AS pizzeria_name
FROM
	person_order AS po
JOIN
	person p ON po.person_id = p.id
JOIN
	menu m ON po.menu_id = m.id
JOIN
	pizzeria pz ON m.pizzeria_id = pz.id
ORDER BY
	person_name ASC,
	pizza_name ASC,
	pizzeria_name ASC;