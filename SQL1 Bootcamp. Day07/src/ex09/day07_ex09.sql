SELECT
	p.address,
	ROUND(MAX(p.age::numeric) - (MIN(p.age::numeric) / MAX(p.age::numeric)), 2) AS formula,
	ROUND(AVG(p.age), 2) AS average,
	(MAX(p.age::numeric) - (MIN(p.age::numeric) / MAX(p.age::numeric)) > AVG(p.age::numeric)) AS comparison
FROM
	person p
GROUP BY
	p.address
ORDER BY
	address;