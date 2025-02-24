SELECT
	name
FROM
	person p
JOIN
	person_order po ON po.person_id = p.id
JOIN
	menu m ON m.id = po.menu_id
WHERE 
	gender = 'male' AND (address = 'Moscow' OR address = 'Samara') AND (m.pizza_name = 'pepperoni pizza' OR m.pizza_name = 'mushroom pizza')
ORDER BY
	p.name DESC;