--fastest quali lap ever for each circuit
SELECT ci.name AS circuit_name,
       d.full_name AS driver_name,
       r.year,
       MIN(rd.qualifying_q3) AS fastest_q3
FROM race_data rd
JOIN race r ON rd.race_id = r.id
JOIN circuit ci ON r.circuit_id = ci.id
JOIN driver d ON rd.driver_id = d.id
WHERE rd.type = 'QUALIFYING_RESULT'
  AND rd.qualifying_q3 IS NOT NULL
GROUP BY ci.name
ORDER BY ci.name;

-- most pole positions
SELECT d.first_name || ' ' || d.last_name AS driver_name,
       COUNT(*) AS poles
FROM qualifying_result qr
JOIN driver d ON qr.driver_id = d.id
WHERE qr.position_number = 1
GROUP BY qr.driver_id
ORDER BY poles DESC
LIMIT 15;

--PIT STOP ANALYSIS
--Average pit stop duration per team for specific season in ms(2022)
SELECT c.name AS constructor,
       ROUND(AVG(ps.time_millis), 3) AS avg_pitstop_mil,
       COUNT(*) AS total_stops
FROM pit_stop ps
JOIN race_result rr ON ps.race_id = rr.race_id AND ps.driver_id = rr.driver_id
JOIN constructor c ON rr.constructor_id = c.id
JOIN race r ON ps.race_id = r.id
WHERE r.year = 2022
GROUP BY rr.constructor_id
ORDER BY avg_pitstop_mil;


--fastest individual pitstops recorded
SELECT d.first_name || ' ' || d.last_name AS driver_name,
       r.official_name AS race_name,
       r.year,
       ps.lap,
       ps.time_millis AS stop_milliseconds
FROM pit_stop ps
JOIN driver d ON ps.driver_id = d.id
JOIN race r ON ps.race_id = r.id
WHERE ps.time_millis IS NOT NULL
ORDER BY ps.time_millis ASC
LIMIT 10;
