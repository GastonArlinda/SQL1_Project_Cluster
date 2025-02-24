WITH date_series AS (
	SELECT
		generate_series('2022-01-01'::date, '2022-01-10'::date, '1 day') AS missing_date
)
SELECT
	ds.missing_date::date
FROM
	date_series AS ds
LEFT JOIN person_visits pv1 ON ds.missing_date = pv1.visit_date AND pv1.person_id = 1
LEFT JOIN person_visits pv2 ON ds.missing_date = pv2.visit_date AND pv2.person_id = 2
WHERE pv1.id IS NULL AND pv2.id IS NULL
ORDER BY
	missing_date ASC;