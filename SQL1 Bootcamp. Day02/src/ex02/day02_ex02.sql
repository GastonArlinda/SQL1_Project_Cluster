SELECT
    CASE WHEN p.name IS NULL THEN '-' ELSE p.name END AS person_name,
    pv.visit_date,
	CASE WHEN pz.name IS NULL THEN '-' ELSE pz.name END AS pizzeria_name
FROM
    person p
LEFT JOIN person_visits pv 
    ON p.id = pv.person_id AND pv.visit_date BETWEEN '2022-01-01' AND '2022-01-03'
FULL JOIN pizzeria pz
	ON pv.pizzeria_id = pz.id
ORDER BY
	person_name,
    visit_date,
    person_name;