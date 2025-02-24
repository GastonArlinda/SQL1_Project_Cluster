SELECT
	person.id,
	person.name,
	age,
	gender,
	address,
	pizzeria.id,
	pizzeria.name,
	rating
FROM
	person
CROSS JOIN
	pizzeria
ORDER BY
	person.id,
	pizzeria.id;