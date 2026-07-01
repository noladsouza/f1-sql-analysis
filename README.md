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



