import os
import subprocess
import signal
import time
from collectResults import collectResults

interrupted = False
algorithm = 'evosql' # evosql / baseline / both
numEvaluations = 10
concurrentProcesses = 5

# Register signal handler
def exit_gracefully(signum, frame):
    interrupted = True

signal.signal(signal.SIGTERM, exit_gracefully)
signal.signal(signal.SIGINT, exit_gracefully)

# Cmd line instruction "java -Dlog4j.configurationFile=log4j2.xml -Xmx4g -Xms2g -jar evaluation.jar " + scenario + " <algorithm>"
def startProcess(scenario):
    cmdArgs = ['java', '-Dlog4j.configurationFile=../../log4j2.xml', '-Xmx4g', '-Xms2g', '-jar', '../../evaluation.jar', scenario, algorithm]
    cwd = os.path.dirname(os.path.realpath(__file__)) + "/scenarios/" + scenario
    return subprocess.Popen(cmdArgs, cwd=cwd)

def runEvaluationRound(outputPrefix):
    scenariosLeft = []
    processes = []
    for scenario in os.listdir("scenarios"):
        # Prefer other systems over erp next
        if ("process" in scenario) and not ("erpnext" in scenario):
            if len(processes) < concurrentProcesses:
                p = startProcess(scenario)
                processes.append(p)
                print(scenario + ' started, pid: ' + str(p.pid))
            else:
                scenariosLeft.append(scenario)
    for scenario in os.listdir("scenarios"):
        if ("process" in scenario) and ("erpnext" in scenario):
            if len(processes) < concurrentProcesses:
                p = startProcess(scenario)
                processes.append(p)
                print(scenario + ' started, pid: ' + str(p.pid))
            else:
                scenariosLeft.append(scenario)

    pReplaced = 0
    pCount = len(processes) + len(scenariosLeft)
    while not interrupted:
        pFinished = 0
        for i in range(len(processes)):
            p = processes[i]
            if p.poll() is not None: #if process is done
                if len(scenariosLeft) > 0:
                    scenario = scenariosLeft.pop(0)
                    newP = startProcess(scenario)
                    processes[i] = newP
                    pReplaced += 1
                    print(scenario + ' started, pid: ' + str(newP.pid))
                else:
                    pFinished += 1
        
        # If all processes are done
        if pFinished + pReplaced == pCount:
            break
        
        time.sleep(10)

    # Kill all process that are still running
    for p in processes:
        if p.poll() is None:
            p.kill()

    # Collect the results into file
    collectResults("scenarios", outputPrefix)

for i in range(numEvaluations):
    if interrupted:
        break
    outputPrefix = "e" + str(i) + "-"
    runEvaluationRound(outputPrefix)


print("Evaluation done")