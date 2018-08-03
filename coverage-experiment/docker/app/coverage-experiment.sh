#!/bin/sh

# Output values for debugging
echo COVERAGE_EXPERIMENT_START is $COVERAGE_EXPERIMENT_START
echo COVERAGE_EXPERIMENT_STEP is $COVERAGE_EXPERIMENT_STEP
echo COVERAGE_EXPERIMENT_STOP is $COVERAGE_EXPERIMENT_STOP

# Run the experiment
for i in {$COVERAGE_EXPERIMENT_START..$COVERAGE_EXPERIMENT_STOP..$COVERAGE_EXPERIMENT_STEP}
do
    java -jar /root/coverage-experiment-all.jar $i
done

# Package all experiment generated files into
# one archive to allow easy copying and portability
tar -zcvf experiment-output.tar.gz ~/experiment-projects
