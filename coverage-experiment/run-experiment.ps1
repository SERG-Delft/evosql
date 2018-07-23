$env:COVERAGE_EXPERIMENT_START = 1;
$env:COVERAGE_EXPERIMENT_STEP = 1;

docker-compose up --build --abort-on-container-exit --force-recreate;
