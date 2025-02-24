SELECT p.name, COUNT(pv.person_id) AS count_of_visits
FROM person_visits pv
JOIN person p ON pv.person_id = p.id
GROUP BY p.name
ORDER BY count_of_visits DESC, p.name
LIMIT 4;