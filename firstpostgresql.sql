SELECT *
FROM city
LIMIT 100;
SELECT table_name
FROM information_schema.tables
WHERE table_schema = 'public';

SELECT *
FROM country
WHERE country = 'Bangladesh'
LIMIT 100


SELECT column_name, data_type
FROM information_schema.columns
WHERE table_name = 'city';
SELECT column_name, data_type
FROM information_schema.columns
WHERE table_name = 'country';

SELECT *
FROM country
WHERE country.name = 'Bangladesh';

SELECT current_database();
