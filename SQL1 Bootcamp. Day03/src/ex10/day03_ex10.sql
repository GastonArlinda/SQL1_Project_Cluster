insert into person_order (id, person_id, menu_id, order_date)
values (
	(SELECT MAX(id) + 1 FROM person_order),
	(SELECT id FROM person WHERE name = 'Denis'),
	(SELECT id FROM menu WHERE pizza_name = 'sicilian pizza'),
	'2022-02-24'
);

insert into person_order (id, person_id, menu_id, order_date)
values (
	(SELECT MAX(id) + 1 FROM person_order),
	(SELECT id FROM person WHERE name = 'Irina'),
	(SELECT id FROM menu WHERE pizza_name = 'sicilian pizza'),
	'2022-02-24'
);