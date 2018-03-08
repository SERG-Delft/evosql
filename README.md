# EvoSQL

[![Build Status](https://travis-ci.org/SERG-Delft/evosql.svg?branch=master)](https://travis-ci.org/SERG-Delft/evosql)
[![Build status](https://ci.appveyor.com/api/projects/status/api940ix5252bwwg/branch/master?svg=true)](https://ci.appveyor.com/project/pvdstel/evosql/branch/master)
[![codecov](https://codecov.io/gh/SERG-Delft/evosql/branch/master/graph/badge.svg)](https://codecov.io/gh/SERG-Delft/evosql)


EvoSQL is a tool that automatically generates test data for your SQL queries.
Behind the scenes, EvoSQL implements a search-based algorithm.

More details can be found in our ICSE 2018 paper. Link to appear.

## Commercial use of EvoSQL

EvoSQL is fully open source. However, our implementation currently makes use of SQLFPc webservice to generate
MC/DC coverage targets, which is provided by University of Oviedo, in Spain. 
Their tool can be only used for research purposes.
For commercial use, you should contact their Tech Transfer Office. More information in 
http://in2test.lsi.uniovi.es/sqltools/common/license.aspx.

## Authors

EvoSQL was initially envisioned by: Jeroen Castelein, Maurício Aniche, 
Mozhan Soltani, Annibale Panichella, and Arie van Deursen.

Other contributors: Paul van der Stel, Daniel van Gelder.

## License

This software is licensed under the Apache 2.0 License. SQLFpc license is explained at
http://in2test.lsi.uniovi.es/sqltools/common/license.aspx.
