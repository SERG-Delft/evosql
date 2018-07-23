$env:COVERAGE_EXPERIMENT_START = 50;
$env:COVERAGE_EXPERIMENT_STEP = 100;

docker-compose up --build --abort-on-container-exit;
