# Inclusive start index
export COVERAGE_EXPERIMENT_START=0
# Step size
export COVERAGE_EXPERIMENT_STEP=1
# Inclusive end index
export COVERAGE_EXPERIMENT_STOP=2008

# Run the experiment
docker-compose up --build --abort-on-container-exit --force-recreate

# Copy results
docker cp "$(docker-compose ps -q app):~/experiment-output.tar.gz" experiment-output.tar.gz
