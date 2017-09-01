/*
 * $Id: math.sql 5406 2014-10-13 20:53:18Z unsaved $
 */

*((x=1+2+3))
* if (*x != 6) \q Tight (non-whitespace) math expression failed

*z = notanum
  *  ((  z  =  1  +  2  +  3  ))  
* if (*z != 6) \q Loose (much-whitespace) math expression failed

-- Force an error with a non-integral variable
-- *x=werd

* ((y =(x*2)/3 -(2 + 2)))
* if (*y != 0) \q Math expression with parenthetical nesting failed

CREATE TABLE t(i INTEGER);

* ((i = 0))
* while (*i < 5)
  -- \p Next is *{i}
  INSERT INTO t VALUES(*{i});
  * ((i = i + 1))
* end while

* c _
SELECT COUNT(*) FROM t;
* if (*c != 5) \q Loop failed to insert right number of records

* r _
SELECT COUNT(*) FROM t WHERE i = 4;
* if (*r != 1) \q Loop failed to insert record with i == 4

*a = 3
*((z=a*2))
*(( z *= 1 + 1 ))
* if (*z != 12) \q Math op #1 failed

-- Series of squares
* sum = 0
* i = 0
* while (*i < 5)
  * ((sum += i*i))
  * ((i++))
* end while
* if (*sum != 30) \q Math summation failed
-- Count back down
* while (*i > 0)
  * ((i-=1)) -- We do not support '--'
  * ((sum -= i*i))
* end while
* if (*sum != 0) \q Reversion of summation failed.  *{sum} left over.

* ((  v1 = (3 + 4) ^ (1 + 2) * 3  ))
* if (*v1 != 1029) \q Power operation failed
