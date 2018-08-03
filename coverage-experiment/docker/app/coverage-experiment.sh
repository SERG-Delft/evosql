#!/bin/bash

# Output values for debugging
echo COVERAGE_EXPERIMENT_START is $COVERAGE_EXPERIMENT_START
echo COVERAGE_EXPERIMENT_STEP is $COVERAGE_EXPERIMENT_STEP
echo COVERAGE_EXPERIMENT_STOP is $COVERAGE_EXPERIMENT_STOP

# Run the experiment
i=$COVERAGE_EXPERIMENT_START
while [ $i -le $COVERAGE_EXPERIMENT_STOP ]
do
    echo "SHELL: executing query $i"
    java -jar /root/coverage-experiment-all.jar $i
    i=$((i+1))
done

# Package all experiment generated files into
# one archive to allow easy copying and portability
tar -zcvf experiment-output.tar.gz ~/experiment-projects
