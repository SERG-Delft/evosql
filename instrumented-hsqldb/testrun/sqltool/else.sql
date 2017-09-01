/**
 * Tests else statement
 */

* RES={
* EXPECTED={ c c23 A c24 A c c23 B c24 B d }
* if (0)
    \q a
    \q b
* else
    * foreach x (A B)
        * RES=*{RES} c
        * if (0) \q c1
        * if (0)
            \q c21 *{x}
            \q c22 *{x}
        * else
            * RES=*{RES} c23 *{x}
            * RES=*{RES} c24 *{x}
        * end if
    * end foreach
    * RES=*{RES} d
* end if
* RES=*{RES} }

* if (*RES != *EXPECTED) \q (*{RES}) vs. (*{EXPECTED})
