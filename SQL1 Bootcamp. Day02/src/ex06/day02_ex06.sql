SELECT 
	m.pizza_name,
	pz.name AS pizzeria_name
FROM 
	person p
JOIN 
	person_order po ON p.id = po.person_id
JOIN
	menu m ON po.menu_id = m.id
JOIN 
	pizzeria pz ON pz.id = m.pizzeria_id
WHERE
	p.name = 'Anna' OR p.name = 'Denis'
ORDER BY
	m.pizza_name,
	pz.name;