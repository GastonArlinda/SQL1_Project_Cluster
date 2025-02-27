INSERT INTO person_visits(id, person_id, pizzeria_id, visit_date)
VALUES (
	(SELECT MAX(id) FROM person_visits) + 1,
	(SELECT id FROM person WHERE name = 'Dmitriy'),
	(SELECT DISTINCT pizzeria.id FROM pizzeria
	JOIN menu m ON pizzeria.id = m.pizzeria_id
	JOIN mv_dmitriy_visits_and_eats mv ON mv.pizzeria_name != pizzeria.name
	WHERE m.price < 800 LIMIT 1),
	'2022-01-08'
);

REFRESH MATERIALIZED VIEW mv_dmitriy_visits_and_eats;