F1 SQL Data Analysis Project



A data analysis project using SQL and the F1DB open-source database,

covering Formula 1 race history from 1950 to present (2026).



\## Data Source

* \[F1DB](https://github.com/f1db/f1db) - open-source F1 database
* Download the latest `f1db.db` from their releases page



\## Tools Used

* DB Browser for SQLite - to run queries
* SQLite - database format
* GitHub - version control and project storage



\## Project Structure

* &#x20;`queries/` - all SQL analysis queries, organised by topic
* &#x20;`notes/` - findings and observations



\## Analysis Areas

1\. Data Exploration

2\. Driver Performance (wins, points, podiums, win rate)

3\. Constructor Analysis

4\. Qualifying Analysis

5\. Pit Stop Strategy

6\. Advanced Queries (trends, head-to-heads, DNF rates)



\## Key Findings

1\_initial.sql

* Driver details- The database contains 917 drivers spanning Formula 1's entire history from 1950 to 2026.
* Races in 2023- The 2023 season ran 22 races from the Bahrain Grand Prix on 5 March to the Abu Dhabi Grand Prix on 26 November, spread across circuits in Europe, the Middle East, Asia and the Americas.
* Races per year- The F1 calendar has grown significantly over time — from just 7 races in 1950 to a peak of 24 races in 2024 and 2025. The 2020 season was notably shortened to only 17 races due to the COVID-19 pandemic.



2\_driver\_analysis.sql

* Top 15 race wins- Lewis Hamilton leads all-time with 106 wins, ahead of Michael Schumacher (91) and Max Verstappen (71). Verstappen is the only active driver in the top 3, having overtaken Schumacher's long-standing record in far fewer career races.
* Leclerc 2023 season- Leclerc had a difficult 2023. He recorded 5 DNFs or non-classified finishes (Bahrain, Australia, Spain, Dutch GP, US GP) and did not win a single race. His best results were three P2 finishes (Austria, Las Vegas, Abu Dhabi), reflecting a Ferrari that was consistently strong enough for the podium but rarely for victory.
* Most podiums- Hamilton again leads with 206 podiums - more than 50 ahead of Schumacher (155). Verstappen's 129 podiums from just 241 races is a remarkable rate for an active driver.
* Win rate (min. 50 races)- Juan Manuel Fangio has the highest win rate at 41.38% - nearly 1 in 2 races - from the 1950s era when fields were smaller. Among modern-era drivers, Schumacher (29.55%) and Verstappen (29.46%) are neck and neck, with Hamilton just behind at 27.32%.



3\_constructor\_analysis.sql

* All-time constructor wins- Ferrari leads all-time with 250 wins, ahead of McLaren (203) and Mercedes (138). However Ferrari's wins span 75 years while Mercedes achieved 138 wins in a much shorter, more dominant period.
* 2008 constructor standings- Ferrari won the 2008 Constructors' Championship with 172 points, narrowly ahead of McLaren on 151. Red Bull finished 7th with just 29 points - remarkable context given their later dominance.
* Constructor win rate (min. 50 races)- Despite Ferrari having the most wins, Mercedes has the highest win rate at 19.27% - nearly 1 in 5 races entered. Red Bull follows at 15.26%. Ferrari's 9.96% rate reflects the sheer volume of races they've competed in over 75 years.



4\_quali\_and\_pitstop\_analysis.sql

* Fastest Q3 lap per circuit- The shortest qualifying lap in the dataset is 1:02.939 by Valtteri Bottas at the Red Bull Ring (Austria) in 2020 - a circuit known for its very short lap length. The José Carlos Pace circuit in Brazil produced Hamilton's 1:07.281 in 2018 and Monaco's tight street circuit saw Lando Norris set a 1:09.954 in 2025.
* Most pole positions- Hamilton leads with 105 pole positions, ahead of Schumacher (69) and Senna (65). Verstappen's 52 poles places him 5th all-time and ahead of legends like Jim Clark and Alain Prost.
* Average pit stop duration by team (2022)- In 2022, Williams had the fastest average pit stop at \~90,469ms (\~90.5 seconds) - note these times are in milliseconds and likely include outlier stops. Red Bull, despite winning the championship, averaged \~125,703ms per stop. This discrepancy may reflect differing data recording methods per team in this season.
* Fastest individual pit stops- The fastest recorded pit stop in the database is Luca Badoer in 2009 at 8,757ms (\~8.8 seconds) - notably from the refuelling era where stops were longer overall. The data here reflects the limitations of early pit stop timing records rather than true sub-2-second modern stops, suggesting the database may only have millisecond-level data from older seasons.



5\_advanced\_queries.sql

* Average finish by nationality- Monégasque (Monaco) drivers have the best average finish position at 5.75 — though from only 3 drivers and 166 races so the sample is small. Among nationalities with large sample sizes, British drivers (123 drivers, 2,800 races) average 6.76 — the best of any major nationality — followed by Finnish (7.32) and Dutch (7.34) drivers.
* Average laps per era- Race distances have shortened dramatically. In the 1950s–60s, races averaged 200 laps (circuits were much shorter). By the 1970s–80s this dropped to 68.7, and the modern era (2010–present) averages just 60 laps, reflecting the standardisation of race distance by time rather than laps in modern regulations.
* Hamilton vs Rosberg 2016- The 2016 title fight was close throughout. Rosberg led early, winning Australia, Bahrain, China, and Russia. Hamilton fought back strongly mid-season, winning Monaco, Canada, Austria, Britain, Hungary, and Germany. Both drivers retired from the Spanish GP (they collided). Rosberg clinched the championship at the final race in Abu Dhabi, finishing P2 behind Hamilton — the minimum he needed to take the title.
* Constructor DNF rate 2005- BAR had the worst reliability in 2005 with a 44.12% DNF rate (15 DNFs from 34 entries) — a season that effectively ended their time in F1. Minardi (36.84%) and Williams (31.58%) also struggled badly. Even Ferrari and Renault, who were fighting for the championship, suffered 21% DNF rates — showing 2005 was a particularly punishing season mechanically.
* Grid position vs race outcome- Starting from pole position delivers an 82.98% podium rate. This drops sharply — P2 gives 73.09%, P3 gives 62.66%, and by P5 it's already down to 35.64%. This confirms qualifying pace is one of the single strongest predictors of race outcome in the modern era.
* Worst reliability since 2018- 2026 data (partial season) shows Aston Martin at a 56.25% DNF rate — very high, though from a small sample of 16 entries. Among completed seasons, Red Bull and Toro Rosso both had 28.57% DNF rates in 2018 — their worst reliability season before their subsequent dominance. McLaren's 26.19% that same year compounded their difficult post-Honda period.
* Drivers who overperform their grid position (2018–present)- Sergio Pérez (+1.64 positions per race) and Esteban Ocon (+1.76) stand out as consistent overtakers among competitive grid drivers. Lance Stroll's +2.22 over 145 races is a surprising finding suggesting strong racecraft that often goes unacknowledged publicly.
* Pit stop count vs finish position- One-stop strategies produce the best average finish (P8.6), identical to 5-stop strategies (though from a much smaller sample of 84 races). Two and three-stop strategies average worse finishes (P9.39 and P10.19), suggesting that extra stops are often reactive (tyre damage, safety cars) rather than strategic choices by frontrunners.
* Driver DNF risk score (2020–present)- Nikita Mazepin leads with a 27.27% DNF rate — 6 retirements in just 22 races. Logan Sargeant (25.0%) and Kevin Magnussen (22.89%) follow. These rates reflect a combination of mechanical reliability, crash incidents, and in some cases underfunded cars from smaller teams.
* Podium probability from grid position- Starting in the top 3 gives a 74.81% podium probability — nearly 3 in 4 races. From P4–6 it drops to 24.38%, from P7–10 it's just 4.65%, and from outside the top 10 only 1.35% of drivers reach the podium. This statistical model confirms that grid position is the most powerful single predictor of podium outcomes.
* Ferrari season-by-season trend (2018–present)- Ferrari's worst season in this period was 2020, averaging a finish of P8.82 per race and just 7.71 points — a sharp decline from their competitive 2018 (P3.19 avg, 15.43 pts). They partially recovered in 2022 (P3.4 avg, 14.83 pts) but reliability cost them — 9 DNFs that year likely contributed to losing what was an initially promising championship challenge against Red Bull.





