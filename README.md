# IPL2026_SQL_Project
# 🏏 IPL 2026 — SQL Analytics Project

> A beginner-to-intermediate SQL project analyzing IPL 2026 batting statistics — covering player performance, team insights, consistency analysis, and advanced business queries.

---

## 📌 Project Overview

This project explores batting data from the **IPL 2026 season** using SQL.  
The dataset contains stats for **151 players** across all **10 franchises**, sourced directly from ESPN Cricinfo.

The queries are organized into 4 categories:

| Category | Queries | Focus |
|---|---|---|
| 🏅 Player Performance | Q1 – Q5 | Top scorers, averages, strike rate, boundaries |
| 🏟️ Team Insights | Q6 – Q10 | Team totals, best SR, top scorer per team |
| 📊 Match & Consistency | Q11 – Q15 | Innings consistency, not-outs, boundary hitters |
| 🧠 Advanced / Business | Q16 – Q20 | Impact score, finishers, boundary %, Orange Cap view |

---

## 📂 Files in This Repo

```
IPL2026_SQL_Project/
│
├── IPLRUNS.csv              # Raw dataset (151 players, 16 columns)
├── IPL_RUNS_QUERY.sql       # All 20 SQL queries
└── README.md                # You're here
```

---

## 🗄️ Dataset

**Source:** [ESPN Cricinfo — IPL 2026 Batting Records](https://www.espncricinfo.com/records/tournament/batting-most-runs-career/indian-premier-league-2026-17740)

**Table name used:** `IPLRUNS`

### Column Reference

| Column | Description |
|---|---|
| `Player` | Player name |
| `Span` | Season (2026-2026) |
| `TEAM` | Franchise (RR, GT, RCB, SRH, DC, LSG, PBKS, CSK, MI, KKR) |
| `Mat` | Matches played |
| `Inns` | Innings batted |
| `NO` | Not outs |
| `Runs` | Total runs scored |
| `HS` | Highest score |
| `Ave` | Batting average |
| `BF` | Balls faced |
| `SR` | Strike rate |
| `HUND` | Centuries (100s) |
| `FIFTY` | Half-centuries (50s) |
| `DUCKS` | Dismissed for 0 |
| `FOURS` | Fours hit |
| `SIXERS` | Sixes hit |

---

## 🔍 Queries at a Glance

### 🏅 Player Performance

```sql
-- Q1: Top 10 run scorers overall
SELECT * FROM IPLRUNS ORDER BY RUNS DESC LIMIT 10;

-- Q2: Players with batting average above 50
SELECT * FROM IPLRUNS WHERE AVE > 50;

-- Q3: Players with 500+ runs and SR > 160
SELECT * FROM IPLRUNS WHERE RUNS > 500 AND SR > 160;

-- Q4: Most sixes in IPL 2026
SELECT PLAYER, SIXERS FROM IPLRUNS ORDER BY SIXERS DESC LIMIT 1;

-- Q5: Players with at least 1 century and 5 fifties
SELECT PLAYER, HUND, FIFTY FROM IPLRUNS WHERE HUND >= 1 AND FIFTY = 5;
```

### 🏟️ Team Insights

```sql
-- Q6: Total runs by each team
SELECT TEAM, SUM(RUNS) FROM IPLRUNS GROUP BY TEAM;

-- Q7: Highest average strike rate by team
SELECT TEAM, MAX(SR) FROM IPLRUNS GROUP BY TEAM;

-- Q8: Top run scorer per team
SELECT TEAM, MAX(RUNS) AS TOP_RUN_SCORER FROM IPLRUNS GROUP BY TEAM;

-- Q9: Teams with most players scoring 300+ runs
SELECT TEAM, COUNT(*) AS RUNS_300 FROM IPLRUNS WHERE RUNS > 300 GROUP BY TEAM;

-- Q10: Average runs per player by team
SELECT TEAM, AVG(RUNS) FROM IPLRUNS GROUP BY TEAM ORDER BY AVG(RUNS) DESC;
```

### 📊 Match & Consistency Analysis

```sql
-- Q11: Players who played 15+ matches with 40+ average
SELECT PLAYER, MAT, AVE FROM IPLRUNS WHERE MAT >= 15 AND AVE >= 40;

-- Q12: Best runs-per-match ratio
SELECT PLAYER, RUNS/MAT AS HIGHEST_RUNS FROM IPLRUNS ORDER BY 2 DESC;

-- Q13: Players with 5+ not outs
SELECT PLAYER, MAT, NO FROM IPLRUNS WHERE NO >= 5;

-- Q14: Players who hit more sixes than fours
SELECT PLAYER, SIXERS, FOURS FROM IPLRUNS WHERE SIXERS > FOURS;

-- Q15: Players with 5+ fifties in at least 5 innings
SELECT PLAYER, FIFTY, INNS FROM IPLRUNS WHERE FIFTY >= 5 AND INNS >= 5;
```

### 🧠 Advanced / Business Queries

```sql
-- Q16: Impact Score = Runs × SR ÷ Matches  (with RANK window function)
SELECT PLAYER, RUNS * SR / MAT AS IMPACT,
       RANK() OVER(ORDER BY RUNS DESC) AS RANKING
FROM IPLRUNS;

-- Q17: Most efficient finisher (SR ≥ 100, 5+ not outs)
SELECT PLAYER, SR, INNS FROM IPLRUNS WHERE SR >= 100 AND NO >= 5;

-- Q18: Top 5 teams by total runs (proxy for partnerships)
SELECT TEAM, SUM(RUNS) FROM IPLRUNS GROUP BY 1 ORDER BY SUM(RUNS) DESC LIMIT 5;

-- Q19: Boundary percentage = (4s + 6s) / BF × 100
SELECT PLAYER, (FOURS + SIXERS) / BF * 100 AS BOUNDARY_PERCENTAGE FROM IPLRUNS;

-- Q20: Orange Cap leaderboard view
SELECT PLAYER, RUNS, AVE, SR, HUND, FIFTY FROM IPLRUNS;
```

---

## 📈 Key Findings

| Insight | Detail |
|---|---|
| 🥇 Most Runs | Vaibhav Sooryavanshi (RR) — 776 runs @ SR 237.30 |
| 🏏 Highest Average | V Kohli (RCB) — avg 56.25 |
| 💥 Most Sixes | Vaibhav Sooryavanshi (RR) — 72 sixes |
| 🏟️ Teams Covered | RR, GT, RCB, SRH, DC, LSG, PBKS, CSK, MI, KKR |
| 📋 Total Players | 151 |

---

## 🛠️ How to Run

1. Import the dataset into your MySQL database:
```sql
CREATE TABLE IPLRUNS (
  Player VARCHAR(100),
  Span VARCHAR(20),
  TEAM VARCHAR(10),
  Mat INT, Inns INT, NO INT,
  Runs INT, HS VARCHAR(10),
  Ave FLOAT, BF INT, SR FLOAT,
  HUND INT, FIFTY INT,
  DUCKS INT, FOURS INT, SIXERS INT
);

LOAD DATA INFILE 'IPLRUNS.csv'
INTO TABLE IPLRUNS
FIELDS TERMINATED BY ','
IGNORE 1 ROWS;
```

2. Run any query from `IPL_RUNS_QUERY.sql`

---

## 🧰 Tools Used

- **MySQL** — query execution
- **ESPN Cricinfo** — data source
- **GitHub** — version control

---

## 👤 Author

**SKY** — CS & IT Student | Aspiring Data Analyst  
📊 Learning SQL • Python • Power BI • Excel

---

## ⭐ If you found this useful, drop a star!
