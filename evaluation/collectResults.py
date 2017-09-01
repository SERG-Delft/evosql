import os

def readScenarioResults(scenarioFolder, scenarioName, output, coverageOutput, dataOutput, first):
    resultsPath = scenarioFolder + "/" + scenarioName + "/results.csv"
    coveragePath = scenarioFolder + "/" + scenarioName + "/coverageResults.csv"
    dataOutputPath = scenarioFolder + "/" + scenarioName + "/dataOutput.csv"
    # Only proceed if results.csv exists
    if not os.path.isfile(resultsPath):
        return False
    
    # Get system and process no from scenarioName
    system = scenarioName[:scenarioName.find("-")]
    processNo = scenarioName[scenarioName.find("process") + 7:]

    with open(resultsPath) as f:
        lines = f.readlines()
        header = lines[0]
        lines = lines[1:]
        # Print header row if needed
        if first:
            output.write("System|Process Number|")
            output.write(header)

        for line in lines:
            output.write(system + "|" + processNo + "|")
            output.write(line)
            
    # Only proceed if coverageResults.csv exists
    if not os.path.isfile(coveragePath):
        return False

    with open(coveragePath) as f:
        lines = f.readlines()
        header = lines[0]
        lines = lines[1:]
        # Print header row if needed
        if first:
            coverageOutput.write("System|Process Number|")
            coverageOutput.write(header)

        for line in lines:
            coverageOutput.write(system + "|" + processNo + "|")
            coverageOutput.write(line)
    
    # Only proceed if dataoutput exists
    if not os.path.isfile(dataOutputPath):
        return False

    with open(dataOutputPath) as f:
        lines = f.readlines()
        header = lines[0]
        lines = lines[1:]
        # Print header row if needed
        if first:
            dataOutput.write("System|Process Number|")
            dataOutput.write(header)

        for line in lines:
            dataOutput.write(system + "|" + processNo + "|")
            dataOutput.write(line)

    return True

def collectResults(scenarioFolder, outputPrefix):
    # Open output
    with open(scenarioFolder + "/" + outputPrefix + "results.psv", "w") as output:
        with open(scenarioFolder +"/" + outputPrefix + "coverageResults.psv", "w") as covOutput:
            with open(scenarioFolder +"/" + outputPrefix + "dataOutput.psv", "w") as dataOutput:
                first = True
                # Loop through each process folder
                for scenario in os.listdir(scenarioFolder):
                    if "process" in scenario:
                        if readScenarioResults(scenarioFolder, scenario, output, covOutput, dataOutput, first):
                            first = False

if __name__ == '__main__':
    collectResults("scenarios", "")