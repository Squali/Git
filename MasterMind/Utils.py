## Module Made to build utilities functions


# Compare two configurations and give the results
# We suppose the colors are different
def compare(config1, config2):
    whiteScore = 0
    redScore = 0
    n = len (config1)
    for i in range (n):
        val = config1[i]
        if val == config2[i]:
            redScore += 1
        elif val in config2:
            whiteScore += 1
    return (whiteScore, redScore)
