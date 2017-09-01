* RES= {
* EXPECTED = { outerA 0 innerA 0 1 innerA 0 2 outerA 1 innerA 1 1 innerA 1 2 outerA 2 innerA 2 1 innerA 2 2 outerB 1 innerB 1 0 outerB 2 innerB 2 0 innerB 2 1 }
* x = 0
* for (*x < 3) ((x += 1))
    * RES = *{RES} outerA *{x}
    * for ((y =1)) (*y < 3) ((y += 1))
        * RES = *{RES} innerA *{x} *{y}
    * end for
* end for

* for ((x =1)) (*x < 3) ((x += 1))
    * RES = *{RES} outerB *{x}
    * for ((y = 0)) (*y < *x) ((y += 1))
        * RES = *{RES} innerB *{x} *{y}
    * end for
* end for
* RES = *{RES} }

* if (*RES != *EXPECTED) \q (*{RES}) != (*{EXPECTED})

* ((summer = 0))
* for ((i = 0)) (*i < 10) ((i += 1))
    * ((summer += i))
* end for
* if (*summer != 45) \q Summation failed.  *{summer} != 45
