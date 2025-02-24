create table if not exists roads (
	point1 varchar,
	point2 varchar,
	cost integer
);

insert into roads (point1, point2, cost)
values
	('a', 'b', 10),
	('b', 'a', 10),
	('a', 'c', 15),
	('c', 'a', 15),
	('a', 'd', 20),
	('d', 'a', 20),
	('b', 'c', 35),
	('c', 'b', 35),
	('b', 'd', 25),
	('d', 'b', 25),
	('c', 'd', 30),
	('d', 'c', 30);

WITH RECURSIVE paths AS (
	SELECT
		point1 AS path,
		point1,
		point2,
		cost
	FROM roads
	WHERE point1 = 'a' 
	
	UNION

	SELECT
		CONCAT(paths.path, ',', roads.point1) AS path,
		roads.point1,
		roads.point2,
		paths.cost + roads.cost
	FROM
		paths
	JOIN roads ON paths.point2 = roads.point1
	WHERE path NOT LIKE CONCAT('%', roads.point1, '%')
)

SELECT 
	cost AS total_cost,
	CONCAT('{', path, ',a}') AS tour
FROM paths
WHERE 
	LENGTH(path) = 7 
	AND point2 = 'a'
ORDER BY total_cost, tour;