insert into menu (id, pizzeria_id, pizza_name, price)
values (
	(SELECT MAX(id) + 1 FROM menu),
	(SELECT id FROM pizzeria WHERE name = 'Dominos'),
	'sicilian pizza',
	900
);