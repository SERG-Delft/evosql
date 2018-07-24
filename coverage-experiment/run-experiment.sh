COVERAGE_EXPERIMENT_START=0
COVERAGE_EXPERIMENT_STEP=1

docker-compose up --build --abort-on-container-exit --force-recreate

docker cp "$(docker-compose ps -q app)/experiment-output.tar.gz" experiment-output.tar.gz
