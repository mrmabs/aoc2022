# Day 2 - SQLite

## Let's make a database! Sorta...

When looking at the problem and thinking of ways to solve it, using a SQL came to mind. Here I have deliberately used the mantra of never writing data to a database if you can calculate it, so the scores and summaries are calculated inline.

## Personal history

I first heavily got into coding MySQL while building Php websites back around '00. I did offload some work to the database engine, but not quite as much as you see here.

Since then I have wound back my use of SQL and running code within SQL servers, electing to use SQLite (as with this code) for storing data from the command line (and even from Bash scripts), or using native formats and drivers from other languages.

## Running

$ `sqlite3 day2.db < day2pt1.sql`

$ `sqlite3 day2.db < day2pt2.sql`
