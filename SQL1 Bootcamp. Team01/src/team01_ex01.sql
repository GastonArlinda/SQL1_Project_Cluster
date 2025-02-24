-- Exercise 01 — Detailed Query

-- Прежде чем углубиться в выполнение этой задачи, пожалуйста, примените следующие инструкции по вставке.

-- 1) insert into currency values (100, 'EUR', 0.85, '2022-01-01 13:29');
-- 2) insert into currency values (100, 'EUR', 0.79, '2022-01-08 13:29');

/* Пожалуйста, напишите SQL-инструкцию, которая возвращает всех пользователей, все балансовые транзакции 
 * (в этой задаче, пожалуйста, игнорируйте валюты, у которых нет ключа в таблице валют) с указанием 
 * названия валюты и расчетного значения валюты в долларах США на следующий день.
*/

-- Ниже приведена таблица с результирующими столбцами и соответствующей формулой расчета.

-- 1) Вам нужно найти ближайший курс валюты к доллару США за прошлый период (t1).
-- 2) Если значение t1 пусто (означает отсутствие курсов в прошлом), то найдите ближайший курс валюты к доллару США в будущем (t2).
-- 3) Используйте курс t1 ИЛИ t2 для расчета валюты в формате USD.

/* Смотрите пример вывода ниже. Отсортируйте результат по имени пользователя в порядке убывания,
 * а затем по фамилии пользователя и названию валюты в порядке возрастания.
*/

-- Вносим изменения:
INSERT INTO currency VALUES (100, 'EUR', 0.85, '2022-01-01 13:29');
INSERT INTO currency VALUES (100, 'EUR', 0.79, '2022-01-08 13:29');

-- Реализуем запрос:
SELECT 
    COALESCE(u.name, 'not defined') AS name,
    COALESCE(u.lastname, 'not defined') AS lastname,
    c.name AS currency_name,
    CAST(b.money * COALESCE(
        (SELECT rate_to_usd
         FROM currency c 
         WHERE b.currency_id = c.id AND c.updated < b.updated 
         ORDER BY c.updated DESC LIMIT 1),
        (SELECT rate_to_usd
         FROM currency c 
         WHERE b.currency_id = c.id AND c.updated > b.updated 
         ORDER BY c.updated ASC LIMIT 1)
    )AS FLOAT) AS currency_in_usd
FROM balance b 
JOIN (SELECT c.id, c.name FROM currency c GROUP BY c.id, c.name) AS c ON c.id = b.currency_id
LEFT JOIN "user" u ON u.id = b.user_id
ORDER BY name DESC, lastname, currency_name;