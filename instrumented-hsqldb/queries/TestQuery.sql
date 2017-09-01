CREATE TABLE thistable ( 
	thiscolumn INT
 ) 

INSERT INTO thistable VALUES (1)

SELECT * FROM thistable WHERE CASE WHEN 1=1 THEN thiscolumn = 1 ELSE thiscolumn = 2 END