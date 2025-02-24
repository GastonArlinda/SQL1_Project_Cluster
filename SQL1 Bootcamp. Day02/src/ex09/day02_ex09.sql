SELECT
	p.name
FROM
	person p
JOIN
	person_order po ON po.person_id = p.id
JOIN
	menu m ON m.id = po.menu_id
WHERE 
	gender = 'female' AND m.pizza_name IN ('pepperoni pizza', 'cheese pizza')
GROUP BY
	p.name
HAVING
    COUNT(DISTINCT m.pizza_name) = 2
ORDER BY
	p.name ASC;