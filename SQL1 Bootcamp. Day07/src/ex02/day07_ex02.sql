(SELECT
	pz.name,
	COUNT(po.person_id),
	'order' AS action_type
FROM
	person_order po
JOIN
	menu m ON po.menu_id = m.id
JOIN
	pizzeria pz ON m.pizzeria_id = pz.id
GROUP BY
	pz.name
ORDER BY
	2 DESC
LIMIT 3)

UNION

(SELECT
	pz.name,
	COUNT(pv.person_id),
	'visit' AS action_type
FROM
	person_visits pv
JOIN
	pizzeria pz ON pv.pizzeria_id = pz.id
GROUP BY
	pz.name
ORDER BY
	2 DESC
LIMIT 3)

ORDER BY
	action_type,
	count DESC;