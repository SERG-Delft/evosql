import os
import subprocess
import signal
import time
import sys
import argparse

interrupted = False
numEvaluations = 10

# Register signal handler
def exit_gracefully(signum, frame):
    interrupted = True

signal.signal(signal.SIGTERM, exit_gracefully)
signal.signal(signal.SIGINT, exit_gracefully)

# Cmd line instruction "java -Dlog4j.configurationFile=log4j2.xml -Xmx4g -Xms2g -jar evaluation.jar " + scenario + " <algorithm>"
def startProcess(scenario, algorithm):
    cmdArgs = ['java', '-Dlog4j.configurationFile=../../log4j2.xml', '-Xmx768m', '-Xms256m', '-jar', '../../evaluation.jar', scenario, algorithm]
    cwd = os.path.dirname(os.path.realpath(__file__)) + "/scenarios/" + scenario
    return subprocess.Popen(cmdArgs, cwd=cwd)

def runEvaluationRound(scenario, algorithm):
    process = startProcess(scenario, algorithm)

    while not interrupted:
        if process.poll() is not None: #if process is done, break
            break
        
        time.sleep(10)

# Get scenario from arguments
parser = argparse.ArgumentParser(description='Run EvoSQL 10 times on given scenario')
parser.add_argument('scenario', help='The scenario process folder to run on')
parser.add_argument('algorithm', help='Algorithm to use: evosql / baseline')

args = parser.parse_args()

for i in range(numEvaluations):
    if interrupted:
        break
    runEvaluationRound(args.scenario, args.algorithm)

print("Evaluation done")