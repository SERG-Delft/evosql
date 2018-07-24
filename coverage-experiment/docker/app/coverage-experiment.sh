#!/bin/sh

# Run the experiment
java -jar /root/coverage-experiment-all.jar $COVERAGE_EXPERIMENT_START $COVERAGE_EXPERIMENT_STEP

# Package all experiment generated files into
# one archive to allow easy copying and portability
tar -zcvf experiment-output.tar.gz ~/experiment-projects
