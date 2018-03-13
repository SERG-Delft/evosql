# EvoSQL

[![Build Status](https://travis-ci.org/SERG-Delft/evosql.svg?branch=master)](https://travis-ci.org/SERG-Delft/evosql)
[![Build status](https://ci.appveyor.com/api/projects/status/api940ix5252bwwg/branch/master?svg=true)](https://ci.appveyor.com/project/pvdstel/evosql/branch/master)
[![codecov](https://codecov.io/gh/SERG-Delft/evosql/branch/master/graph/badge.svg)](https://codecov.io/gh/SERG-Delft/evosql)


EvoSQL is a tool that automatically generates test data for your SQL queries.
Behind the scenes, EvoSQL implements a search-based algorithm.

More details can be found in our paper:
_Castelein, J, Aniche, M, Soltani, M, Panichella, A & van Deursen, A 2018, Search-Based Test Data Generation for SQL Queries. in Proceedings of the 40th International Conference on Software Engineering. ICSE 2018, Gothenborg, Sweden, 26 May. DOI: 10.1145/3180155.3180202_. [Download](https://pure.tudelft.nl/portal/en/publications/searchbased-test-data-generation-for-sql-queries(90a6431f-f78f-4ac3-bf87-c052cd9cd5d4)/export.html)

## SQLFpc's license

EvoSQL currently makes use of SQLFPc webservice to generate
MC/DC coverage targets, which is provided by University of Oviedo, in Spain. 
Their tool can be only used for research purposes.

For any commercial use, you should contact their Tech Transfer Office. More information 
about their license in 
http://in2test.lsi.uniovi.es/sqltools/common/license.aspx.

## Compiling EvoSQL

For our Gradle build to work, you first should download the `sqlrules.jar` binary
from this link, and copy it to our `lib/` folder: 
http://in2test.lsi.uniovi.es/sqltools/sqlrules/?lang=en. 


## Authors

EvoSQL was initially envisioned by: Jeroen Castelein, Maurício Aniche, 
Mozhan Soltani, Annibale Panichella, and Arie van Deursen.

Other contributors: Paul van der Stel, Daniel van Gelder.

## License

This software is licensed under the Apache 2.0 License. SQLFpc license is explained at
http://in2test.lsi.uniovi.es/sqltools/common/license.aspx.
