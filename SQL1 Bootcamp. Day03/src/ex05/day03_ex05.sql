SELECT pz.name AS pizzeria_name
FROM person_visits pv
JOIN pizzeria pz ON pv.pizzeria_id = pz.id
WHERE pv.person_id = (
	SELECT id
	FROM person
	WHERE name = 'Andrey'
)
AND pv.pizzeria_id NOT IN (
	SELECT m.pizzeria_id
	FROM person_order po
	JOIN menu m ON po.menu_id = m.id
	WHERE po.person_id = (
		SELECT id
		FROM person
		WHERE name = 'Andrey'
	)
)
ORDER BY pizzeria_name;