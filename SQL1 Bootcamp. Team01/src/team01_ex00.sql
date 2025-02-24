WITH cte_last_rate_to_usd AS (
	SELECT
		c.id,
		c.name AS currency_name,
		(SELECT rate_to_usd FROM currency c
		WHERE c.updated IN (SELECT MAX(c.updated) FROM currency c)
		AND id = b.currency_id) AS last_rate_to_usd
	FROM
		currency c
	JOIN
		balance b ON c.id = b.currency_id
	GROUP BY
		c.id, c.name, b.currency_id
)

SELECT
	COALESCE(u.name, 'not defined') AS name,
	COALESCE(u.lastname, 'not defined') AS lastname,
	b.type,
	SUM(b.money) AS volume,
	COALESCE(lru.currency_name, 'not defined') AS currency_name,
	COALESCE(lru.last_rate_to_usd, 1) AS last_rate_to_usd,
	SUM(b.money) * COALESCE(lru.last_rate_to_usd, 1) AS total_volume_in_usd
FROM
	balance b
FULL JOIN
	"user" u ON u.id = b.user_id
LEFT JOIN
	cte_last_rate_to_usd lru ON lru.id = b.currency_id
GROUP BY
	name, lastname, b.type, currency_name, last_rate_to_usd
ORDER BY
	name DESC, lastname ASC, b.type ASC;