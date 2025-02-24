WITH po_c AS (
	SELECT
		pz.name,
		COUNT(po.person_id)
	FROM
		person_order po
	JOIN
		menu m ON po.menu_id = m.id
	JOIN
		pizzeria pz ON m.pizzeria_id = pz.id
	GROUP BY
		pz.name
),

pv_c AS (
	SELECT
		pz.name,
		COUNT(pv.person_id)
	FROM
		person_visits pv
	JOIN
		pizzeria pz ON pv.pizzeria_id = pz.id
	GROUP BY
		pz.name
)

SELECT
	pz.name,
	COALESCE(po_c.count, 0) + COALESCE(pv_c.count, 0) AS total_count
FROM 
	pizzeria pz
FULL JOIN
	po_c ON po_c.name = pz.name
FULL JOIN
	pv_c ON pv_c.name = pz.name
ORDER BY
	total_count DESC,
	name;