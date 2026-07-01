-- top 15 drivers with most race wins
SELECT d.first_name || ' ' || d.last_name AS driver_name,
       COUNT(*) AS total_wins
FROM race_result rr
JOIN driver d ON rr.driver_id = d.id
WHERE rr.position_number = 1
GROUP BY rr.driver_id
ORDER BY total_wins DESC
LIMIT 15;

--specific driver stat in specific szn
SELECT d.first_name || ' ' || d.last_name AS driver_name,
       r.official_name AS race_name,
       rr.position_number AS finish_position,
       rr.points
FROM race_result rr
JOIN driver d ON rr.driver_id = d.id
JOIN race r ON rr.race_id = r.id
WHERE r.year = 2023
  AND d.last_name = 'Leclerc' AND first_name = 'Charles'
ORDER BY r.round;

--drivers with most podiums 
SELECT d.first_name || ' ' || d.last_name AS driver_name,
       COUNT(*) AS podiums
FROM race_result rr
JOIN driver d ON rr.driver_id = d.id
WHERE rr.position_number IN (1, 2, 3)
GROUP BY rr.driver_id
ORDER BY podiums DESC
LIMIT 15;

--win rate (wins per races entered)
SELECT d.first_name || ' ' || d.last_name AS driver_name,
       COUNT(*) AS races,
       SUM(CASE WHEN rr.position_number = 1 THEN 1 ELSE 0 END) AS wins,
       ROUND(100.0 * SUM(CASE WHEN rr.position_number = 1 THEN 1 ELSE 0 END) / COUNT(*), 2) AS win_rate_pct
FROM race_result rr
JOIN driver d ON rr.driver_id = d.id
GROUP BY rr.driver_id
HAVING COUNT(*) >= 50
ORDER BY win_rate_pct DESC
LIMIT 15;
