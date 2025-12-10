📊 SQL Plan History Tracker (Oracle):
=====================================

This project provides a lightweight, production-ready solution for tracking SQL execution plan changes (plan flips) in Oracle databases.
It captures plan structure + execution statistics by combining:

v$sqlstats_plan_all → Plan details

v$sqlstats → Runtime/Performance details

The result is a unified historical repository that DBAs can use to analyze plan instability, regressions, and performance patterns beyond AWR retention.

🚀 Features:
-------------
✔ Track SQL plan flips beyond AWR window
Stores plan versions in your own table with unlimited retention.

✔ Merges plan metadata + runtime statistics
Captures both structural plan details and performance metrics.

✔ Uses v$sqlstats (Oracle-recommended)
More stable and less noisy compared to v$sql.

✔ Supports filtering rules (optional)
You can enable filters to avoid storing trivial ad-hoc SQL.

✔ Ready for automation
Works perfectly with DBMS_SCHEDULER for hourly/daily capture.

📈 Usage Ideas:
----------------
Identify SQL plan flips over time.
Detect regressions between plan versions.
Compare PLAN COST vs. RUNTIME COST deltas.
Feed into automatic baseline creation strategies.
