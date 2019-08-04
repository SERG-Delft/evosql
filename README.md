# EvoSQL

[![Build Status](https://travis-ci.org/SERG-Delft/evosql.svg?branch=master)](https://travis-ci.org/SERG-Delft/evosql)
[![Build status](https://ci.appveyor.com/api/projects/status/api940ix5252bwwg/branch/master?svg=true)](https://ci.appveyor.com/project/pvdstel/evosql/branch/master)
[![codecov](https://codecov.io/gh/SERG-Delft/evosql/branch/master/graph/badge.svg)](https://codecov.io/gh/SERG-Delft/evosql)


EvoSQL is a tool that automatically generates test data for your SQL queries.
Behind the scenes, EvoSQL implements a search-based algorithm.

More details can be found in our paper:
_Castelein, J, Aniche, M, Soltani, M, Panichella, A & van Deursen, A 2018, Search-Based Test Data Generation for SQL Queries. in Proceedings of the 40th International Conference on Software Engineering. ICSE 2018, Gothenborg, Sweden, 26 May. DOI: 10.1145/3180155.3180202_. [Download](https://pure.tudelft.nl/portal/en/publications/searchbased-test-data-generation-for-sql-queries(90a6431f-f78f-4ac3-bf87-c052cd9cd5d4)/export.html)

## Procedure

1. Open the project in your preferred IDE and make sure to support Gradle and Maven. 
Make sure the Lombok plugin has been installed and annotation processing is enabled. 
2. Execute the 'jar' task in the Gradle menu.
3. Go to `evosql > brew > build > libs`. Here you will find `evosql.jar`
4. Open the command line window and go to the directory where the jar is located on your machine.
4. Execute the jar in the following format: 
`java -jar evosql.jar yourSQLqueries.sql theJdbcString username pw=yourpassword pkg=packagename cls=classname [pathForOutputFile]`
where `pkg` and `cls` are the package name and class name of the to be generated test file. This test data will be printed in the command line window if the `pathForOutputFile` is empty.

## Authors

EvoSQL was initially envisioned by: Jeroen Castelein, Maurício Aniche, 
Mozhan Soltani, Annibale Panichella, and Arie van Deursen.

Other contributors: Paul van der Stel, Daniel van Gelder.

## License

This software is licensed under the Apache 2.0 License.

