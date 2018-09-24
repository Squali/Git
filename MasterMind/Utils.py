# Module Made to build utilities functions


# Compare two configurations and give the results
# We suppose the colors are different

__all__ = ["selectConfig", "updateSet"]


# Compare two configurations
def compare(config1, config2):
    whiteScore = 0
    redScore = 0
    n = len(config1)
    for i in range(n):
        val = config1[i]
        if val == config2[i]:
            redScore += 1
        elif val in config2:
            whiteScore += 1
    return (whiteScore, redScore)


# Update List of admissible set
def updateSet(config, result, setConfig):
    return filter(lambda x: (compare(config, x) == result), setConfig)


# Create Partition of the set
def createPartition(config, setConfig):
    setResult = [(i, j) for i in range(5) for j in range(5-i)]
    setResult.remove((1, 3))
    return dict(zip(setResult, map(lambda x: updateSet(config, x, setConfig), setResult)))


# Function that, for a given configuration, gives the cardinal of the largest set in the partition generated
def worstCaseValue(config, setConfig):
    setResult = [(i, j) for i in range(5) for j in range(5-i)]
    setResult.remove((1, 3))
    return max(map(lambda x: len(updateSet(config, x, setConfig)), setResult))


# Select the worst case configuration
def selectConfig(setConfig):
    debugging = zip(map(lambda x: tuple(x), setConfig), map(
        lambda x: worstCaseValue(x, setConfig), setConfig))
    d = dict(debugging)
    return min(d, key=d.get)
