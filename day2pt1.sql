DROP TABLE IF EXISTS rps;
DROP VIEW IF EXISTS scores;
CREATE TABLE rps(them TEXT, me TEXT);
.separator " "
.import day2-input.txt rps
.separator ","
CREATE VIEW scores AS
SELECT them,me,
	CASE 
	    WHEN them="A"
		THEN
		    CASE 
			WHEN me="Y" 
			    THEN 6
			WHEN me="X" 
			    THEN 3
			ELSE 0
		    END
	    WHEN them="B"
		THEN
		    CASE
			WHEN me="Z"
			    THEN 6
			WHEN me="Y"
			    THEN 3
			ELSE 0
		    END
	    WHEN them="C"
		THEN
		    CASE
			WHEN me="X"
			    THEN 6
			WHEN me="Z"
			    THEN 3
			ELSE 0
		    END
    	END +
	CASE 
	    WHEN me="X" THEN 1
	    WHEN me="Y" THEN 2
	    WHEN me="Z" THEN 3
	END AS score
from rps;

SELECT SUM(score) from scores;
