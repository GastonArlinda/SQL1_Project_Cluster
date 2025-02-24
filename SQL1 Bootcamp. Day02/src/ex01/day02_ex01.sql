SELECT
	gs::date AS missing_date
FROM
	generate_series('2022-01-01'::date, '2022-01-10'::date, '1 day') AS gs
LEFT JOIN person_visits pv1 ON gs = pv1.visit_date AND pv1.person_id = 1
LEFT JOIN person_visits pv2 ON gs = pv2.visit_date AND pv2.person_id = 2
WHERE pv1.id IS NULL AND pv2.id IS NULL
ORDER BY
	missing_date ASC;