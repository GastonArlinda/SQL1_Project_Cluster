SELECT
	pz.name AS pizzeria_name
FROM
	pizzeria pz
JOIN
	person_visits pv ON pz.id = pv.pizzeria_id
JOIN
	person p ON pv.person_id = p.id
GROUP BY
    pz.name
HAVING
    SUM(CASE WHEN p.gender = 'female' THEN 1 ELSE 0 END) != SUM(CASE WHEN p.gender = 'male' THEN 1 ELSE 0 END)
ORDER BY
    pizzeria_name;