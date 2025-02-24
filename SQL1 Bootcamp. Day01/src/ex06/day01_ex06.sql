SELECT
	po.action_date,
	p.name as person_name
FROM
	(SELECT 
	    order_date AS action_date,
	    person_id
	FROM
	    person_order
	
	INTERSECT
	
	SELECT
	    visit_date AS action_date,
	    person_id
	FROM
	    person_visits) AS po
JOIN
	person p ON po.person_id = p.id
ORDER BY
    po.action_date ASC,
    p.name DESC;