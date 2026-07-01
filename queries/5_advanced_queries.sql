SELECT co.name AS nationality,
       ROUND(AVG(rr.position_number), 2) AS avg_finish,
       COUNT(DISTINCT d.id) AS num_drivers,
       COUNT(*) AS total_races
FROM race_result rr
JOIN driver d ON rr.driver_id = d.id
JOIN country co ON d.nationality_country_id = co.id
WHERE rr.position_number IS NOT NULL
GROUP BY d.nationality_country_id
HAVING COUNT(DISTINCT d.id) >= 3
ORDER BY avg_finish ASC
LIMIT 15;


--avg laps per era
SELECT 
  CASE 
    WHEN year BETWEEN 1950 AND 1969 THEN '1950s-60s'
    WHEN year BETWEEN 1970 AND 1989 THEN '1970s-80s'
    WHEN year BETWEEN 1990 AND 2009 THEN '1990s-2000s'
    ELSE '2010s-present'
  END AS era,
  ROUND(AVG(scheduled_laps), 1) AS avg_laps
FROM race
WHERE scheduled_laps IS NOT NULL
GROUP BY era
ORDER BY era;

-- ham vs ros 2016
SELECT r.official_name AS race_name,
       r.year,
       d1.last_name AS driver1,
       rr1.position_number AS pos1,
       d2.last_name AS driver2,
       rr2.position_number AS pos2
FROM race_result rr1
JOIN race_result rr2 ON rr1.race_id = rr2.race_id
                     AND rr1.constructor_id = rr2.constructor_id
                     AND rr1.driver_id != rr2.driver_id
JOIN driver d1 ON rr1.driver_id = d1.id
JOIN driver d2 ON rr2.driver_id = d2.id
JOIN race r ON rr1.race_id = r.id
WHERE d1.last_name = 'Hamilton'
  AND d2.last_name = 'Rosberg'
  AND r.year = 2016
ORDER BY r.round;


--constructor dnf rate after 2005
SELECT c.name AS constructor,
       COUNT(*) AS total_entries,
       SUM(CASE WHEN rr.reason_retired IS NOT NULL THEN 1 ELSE 0 END) AS dnfs,
       ROUND(100.0 * SUM(CASE WHEN rr.reason_retired IS NOT NULL THEN 1 ELSE 0 END) / COUNT(*), 2) AS dnf_rate_pct
FROM race_result rr
JOIN constructor c ON rr.constructor_id = c.id
JOIN race r ON rr.race_id = r.id
WHERE r.year = 2005
GROUP BY rr.constructor_id
HAVING COUNT(*) >= 10
ORDER BY dnf_rate_pct DESC;

--determining if grid position actually determine race outcome
SELECT rr.grid_position_number,
       ROUND(AVG(rr.position_number),2) AS avg_finish_position,
       ROUND(100.0 * SUM(CASE WHEN rr.position_number <= 3 THEN 1 ELSE 0 END) / COUNT(*), 2) AS podium_rate_pct,
       COUNT(*) AS sample_size
FROM race_result rr
WHERE rr.grid_position_number IS NOT NULL
  AND rr.position_number IS NOT NULL
  AND rr.grid_position_number BETWEEN 1 AND 20
GROUP BY rr.grid_position_number
ORDER BY rr.grid_position_number;
--result: Starting P1 gives an 83% podium rate vs much lower further back- proving qualifying is one of the strongest predictors of race outcome.

--cons. with worst reliability (max dnfs) after 2018
SELECT c.name AS constructor,
       r.year,
       COUNT(*) AS total_entries,
       SUM(CASE WHEN rr.reason_retired IS NOT NULL THEN 1 ELSE 0 END) AS dnfs,
       ROUND(100.0 * SUM(CASE WHEN rr.reason_retired IS NOT NULL THEN 1 ELSE 0 END) / COUNT(*), 2) AS dnf_rate_pct
FROM race_result rr
JOIN constructor c ON rr.constructor_id = c.id
JOIN race r ON rr.race_id = r.id
WHERE r.year >= 2018
GROUP BY c.id, r.year
HAVING COUNT(*) >= 10
ORDER BY dnf_rate_pct DESC
LIMIT 15;

--Which drivers consistently overperform their grid position?
SELECT d.full_name AS driver_name,
       ROUND(AVG(rr.grid_position_number - rr.position_number),2) AS avg_positions_gained,
       COUNT(*) AS races
FROM race_result rr
JOIN driver d ON rr.driver_id = d.id
JOIN race r ON rr.race_id = r.id
WHERE rr.grid_position_number IS NOT NULL
  AND rr.position_number IS NOT NULL
  AND r.year >= 2018
GROUP BY rr.driver_id
HAVING COUNT(*) >= 30
ORDER BY avg_positions_gained DESC
LIMIT 15;

--Does pit stop count predict finishing position?
SELECT rr.pit_stops,
       ROUND(AVG(rr.position_number),2) AS avg_finish_position,
       COUNT(*) AS races
FROM race_result rr
JOIN race r ON rr.race_id = r.id
WHERE rr.pit_stops IS NOT NULL
  AND rr.position_number IS NOT NULL
  AND r.year >= 2015
GROUP BY rr.pit_stops
ORDER BY rr.pit_stops;

-- Driver DNF risk score
SELECT d.full_name AS driver_name,
       COUNT(*) AS total_races,
       SUM(CASE WHEN rr.reason_retired IS NOT NULL THEN 1 ELSE 0 END) AS dnfs,
       ROUND(100.0 * SUM(CASE WHEN rr.reason_retired IS NOT NULL THEN 1 ELSE 0 END) / COUNT(*), 2) AS historical_dnf_rate_pct
FROM race_result rr
JOIN driver d ON rr.driver_id = d.id
JOIN race r ON rr.race_id = r.id
WHERE r.year >= 2020
GROUP BY rr.driver_id
HAVING COUNT(*) >= 20
ORDER BY historical_dnf_rate_pct DESC
LIMIT 15;

-- Podium probability based on grid position bucket
SELECT 
  CASE 
    WHEN rr.grid_position_number <= 3 THEN 'Front Row/Row 2 (1-3)'
    WHEN rr.grid_position_number <= 6 THEN 'Top 6 (4-6)'
    WHEN rr.grid_position_number <= 10 THEN 'Top 10 (7-10)'
    ELSE 'Outside Top 10 (11+)'
  END AS grid_bucket,
  COUNT(*) AS total_races,
  SUM(CASE WHEN rr.position_number <= 3 THEN 1 ELSE 0 END) AS podiums,
  ROUND(100.0 * SUM(CASE WHEN rr.position_number <= 3 THEN 1 ELSE 0 END) / COUNT(*), 2) AS podium_probability_pct
FROM race_result rr
JOIN race r ON rr.race_id = r.id
WHERE rr.grid_position_number IS NOT NULL
  AND rr.position_number IS NOT NULL
  AND r.year >= 2015
GROUP BY grid_bucket
ORDER BY podium_probability_pct DESC;

-- Team performance trend diagnosing a season-by-season decline
SELECT c.name AS constructor,
       r.year,
       ROUND(AVG(rr.position_number),2) AS avg_finish_position,
       ROUND(AVG(rr.points),2) AS avg_points_per_race,
       SUM(CASE WHEN rr.reason_retired IS NOT NULL THEN 1 ELSE 0 END) AS dnfs
FROM race_result rr
JOIN constructor c ON rr.constructor_id = c.id
JOIN race r ON rr.race_id = r.id
WHERE c.name = 'Ferrari'
  AND r.year >= 2018
GROUP BY r.year
ORDER BY r.year;