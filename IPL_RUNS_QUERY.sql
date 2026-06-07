-- PLAYER PERFORMACE 
-- Assuming table name = batting_stats
-- Column 'Player' contains "Name (TEAM)"

-- 1.Find the top 10 run scorers overall
SELECT * 
FROM IPLRUNS
order by RUNS DESC
LIMIT 10;

-- 2.List players with a batting average above 50
SELECT * 
FROM IPLRUNS
WHERE AVE>50;

-- 3.Identify players who scored more than 500 runs with SR > 160
SELECT *
FROM IPLRUNS
WHERE RUNS>500 AND SR >160; 

-- 4.Show the player with most sixes in IPL 2026
SELECT 
PLAYER , SIXERS
FROM IPLRUNS
order by SIXERS DESC
LIMIT 1;

-- 5.Find players who scored at least 1 century and 5 fifties.
SELECT 
PLAYER , HUND,FIFTY
FROM IPLRUNS
WHERE HUND>=1 AND FIFTY =5;

-- TEAM INSIGHT:
-- 6.Calculate total runs scored by each team.
SELECT 
TEAM , SUM(RUNS)
FROM IPLRUNS
GROUP BY TEAM;

-- 7.Find the team with highest average strike rate across all players
SELECT 
TEAM , MAX(SR)
FROM IPLRUNS
GROUP BY TEAM;

-- 8.Show the top run scorer for each team
SELECT 
TEAM ,MAX(RUNS) AS TOP_RUN_SCORER
FROM IPLRUNS
GROUP BY TEAM ;

 -- 9.Find the team with most players scoring 300+ runs
 SELECT 
 TEAM ,COUNT(*) AS RUNS_300
 FROM IPLRUNS
 WHERE RUNS>300
 GROUP BY TEAM;
 
 -- 10.Compare average runs per player between teams
SELECT 
TEAM ,AVG(RUNS)
FROM IPLRUNS
GROUP BY TEAM
ORDER BY AVG(RUNS) DESC;

-- Match & Consistency Analysis

-- 11.List players who played more than 15 matches and averaged 40+ runs
SELECT 
PLAYER,MAT,AVE
FROM IPLRUNS
WHERE MAT>=15 AND AVE>=40;

-- 12.Find players with highest runs per match ratio
SELECT 
PLAYER , RUNS/MAT AS HIGHEST_RUNS
FROM  IPLRUNS 
ORDER BY 2 DESC;

-- 13.Show players who remained not out in more than 5 innings
SELECT 
PLAYER , MAT,no
FROM IPLRUNS
WHERE NO>=5;

-- 14.Identify players with more sixes than fours
SELECT 
PLAYER , SIXERS , FOURS 
FROM IPLRUNS
WHERE SIXERS > FOURS;

-- 15.Find players who scored 50+ in at least 5 innings
SELECT PLAYER , FIFTY , INNS 
FROM IPLRUNS
WHERE FIFTY >= 5 AND INNS >=5;

-- Advanced Business Queries

-- 16.Rank players by “impact score” = Runs × Strike Rate ÷ Matches
SELECT PLAYER,RUNS * SR/ MAT AS IMPACT 
, RANK () OVER(
ORDER BY RUNS DESC 
 ) AS RANKING 
FROM IPLRUNS;

-- 17.Find the most efficient finisher (highest SR among players with ≥ 100 runs and ≥ 5 not outs)
SELECT 
PLAYER,SR ,INNS 
FROM IPLRUNS
WHERE SR>=100 AND NO>=5;

-- 18.Show the top 5 partnerships (use team + runs grouping).
SELECT TEAM , SUM(RUNS)
FROM IPLRUNS
GROUP BY 1
ORDER BY SUM(RUNS) DESC
LIMIT 5
;
SELECT * FROM IPLRUNS;
-- 19.Find the player with best boundary percentage = (4s+6s)/BF × 100
SELECT 
PLAYER , (FOURS+SIXERS)/BF*100 AS BOUNDARY_PERCANTAGE
FROM IPLRUNS;

-- 20.Create a view for Orange Cap leaderboard (Player, Runs, Avg, SR, 100s, 50s).
SELECT 
PLAYER , RUNS ,AVE,SR , HUND,FIFTY
FROM IPLRUNS;

 


