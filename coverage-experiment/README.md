# Introduction
This sub-project contains the implementation for our EvoSQL coverage experiment. The goal of this experiment is to demonstrate the validity of the brew project within EvoSQL in terms of query path coverage. In other words, it demonstrates how well brew tests a query given the resulting data from EvoSQL. We show this by using the generated tests for a query and running them on a mutation of that query. In the case that brew and EvoSQL generate correct tests, these tests should fail for a mutation and thus fulfill the goal of EvoSQL.

# Outline of structure
The main operations of the experiment are performed within the `Runner` class, which with the help of some helper classes performs the entire pipeline of:
- Getting a query
- Running EvoSQL on that query
- Use the resulting data to generate executable code using brew
- Mutating the query
- Generate more code using the same data, but using the mutated query
- Executing all tests for that query
- Exporting the test results

The operations within the experiment follow this same order.

# Executing the experiment
## Prerequisites
There are some requirements to meet in other to run the experiment:
- A working internet connection.
- A running Docker installation. Running the experiment without Docker is possible, but not recommended due to the combination of services used in the experiment.
- The `sqlrules.jar` file for EvoSQL (download it by running the `get-sqlfpc` script in the `evosql/lib` directory).

## Starting the experiment
1. Open a terminal and go to the directory of the coverage experiment (this directory, `evosql\coverage-experiment`).
2. Run `gradle clean` if you have old build artifacts remaining
3. Run `gradle shadowJar`
4. Edit the `run-experiment` script (`.ps1` if you're on Windows, `.sh` if you're on a UNIX system)
5. Change the parameters `COVERAGE_EXPERIMENT_START` and `COVERAGE_EXPERIMENT_STEP`, which respectively specify the starting index of queries to read and the step size for iterating through the query list.
6. Open the terminal again and run the script.

## Retrieving experiment results
The Docker container executing the experiment will generate a `.tar.gz` archive containing the results. The script copies this file from the container to the current directory. It contains a list of gradle projects, one for each query the experiment was run on. Each project is named after the index of the corresponding query. It will contain a set of generated test classes for the query and its mutations. In addition, there will also be a directory `results` with an `all.csv` file outlining the results of executing the test classes within that project in an easily parseable format. If any exceptions occured during executions, there will also be `.xml` files which describe the exception and its stacktrace. If the experiment for a query was succesful and as expected then the test class `Original` will pass and all `Mutated` classes will have at least one failure and no exceptions.

## Analysing experiment results
An analysis of the results of the experiment can be performed by combining the `all.csv` files of all the queries the experiment was run on which should be easily parseable by _R_ or _MATLAB_. The structure of the `all.csv` files is as follows:

<!-- TODO: Structure needs to be added once it is finished -->
`STRUCTURE`

If exceptions should be analyzed the `.xml` files should be considered and parsed. The following structure can be expected:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<testsuite name="package.TestClass" tests="0" skipped="0" failures="0" errors="0" timestamp="1970-01-01T00:00:00" hostname="b6c3bb2ffd6c" time="0.0">
  <properties/>
  <testcase name="failingTestMethod" classname="package.TestClass" time="0.0">
    <failure message="Failure Message" type="typeOfException">
        Failure Message and Stacktrace
    </failure>
  </testcase>
  <testcase name="passingTestMethod" classname="package.TestClass" time="0.0">
  </testcase>
  <system-out><![CDATA[]]></system-out>
  <system-err><![CDATA[]]></system-err>
</testsuite>
```
