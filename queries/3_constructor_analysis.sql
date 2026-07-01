--all time constructor wins
SELECT c.name AS constructor_name,
       COUNT(*) AS wins
FROM race_result rr
JOIN constructor c ON rr.constructor_id = c.id
WHERE rr.position_number = 1
GROUP BY rr.constructor_id
ORDER BY wins DESC
LIMIT 10;

--constructor standings for specific season
SELECT c.name AS constructor,
       scs.position_number,
       scs.points
FROM season_constructor_standing scs
JOIN constructor c ON scs.constructor_id = c.id
WHERE scs.year = 2008
ORDER BY scs.position_number;


-- constructor win rate
SELECT c.name AS constructor_name,
       COUNT(*) AS races,
       SUM(CASE WHEN rr.position_number = 1 THEN 1 ELSE 0 END) AS wins,
       ROUND(100.0 * SUM(CASE WHEN rr.position_number = 1 THEN 1 ELSE 0 END) / COUNT(*), 2) AS win_rate_pct
FROM race_result rr
JOIN constructor c ON rr.constructor_id = c.id
GROUP BY rr.constructor_id
HAVING COUNT(*) >= 50
ORDER BY win_rate_pct DESC
LIMIT 15;