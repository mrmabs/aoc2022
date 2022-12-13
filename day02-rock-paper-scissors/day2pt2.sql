DROP TABLE IF EXISTS rps;
DROP VIEW IF EXISTS scores;
CREATE TABLE rps(them TEXT, me TEXT);
.separator " "
.import day2-input.txt rps
.separator ","
CREATE VIEW scores AS
SELECT them,me,
	(CASE
	    WHEN them="A" THEN 1
	    WHEN them="B" THEN 2
	    WHEN them="C" THEN 3
	END +
	CASE
	    WHEN me="X" THEN 2
	    WHEN me="Y" THEN 3
	    WHEN me="Z" THEN 4
	END)%3 as play,
	CASE
	    WHEN me="X" THEN 0
	    WHEN me="Y" THEN 3
	    WHEN me="Z" THEN 6
	END AS game
from rps;

SELECT SUM(CASE
	WHEN play=0 THEN 3
	WHEN play=1 THEN 1
	WHEN play=2 THEN 2
	END + game) from scores;
