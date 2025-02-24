SELECT
	pizza_name,
	pz.name AS pizzeria_name,
	price
FROM
	menu m
JOIN 
	pizzeria pz ON m.pizzeria_id = pz.id
WHERE 
	m.pizza_name = 'mushroom pizza' OR m.pizza_name = 'pepperoni pizza'
ORDER BY
	pizza_name,
	pizzeria_name;

