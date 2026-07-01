--driver details
SELECT id, first_name, last_name, nationality_country_id, date_of_birth
FROM driver
ORDER BY last_name;

--races in a particular year (2023)
SELECT round, official_name, date, circuit_id
FROM race
WHERE year = 2023
ORDER BY round;

-- total number of races in each year
SELECT year, COUNT(*) AS total_races
FROM race
GROUP BY year
ORDER BY year DESC;

