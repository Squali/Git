from Utils import *
from InputAlgo import *
from random import sample

# Test Module


def main():
    return mastermind(consoleInput)


def mastermind(functionInput):
    setConfig = [[i, j, k, l] for i in range(8) for j in range(8) for k in range(8) for l in range(8) if i != j and i != k and i != l and j != k and j != l and k != l]
    print ("Configuration to play : [0,1,2,3]")
    currentConfig = [0, 1, 2, 3]
    result = functionInput()
    setConfig = updateSet(currentConfig, result, setConfig)
    while (len(setConfig) > 1):
        currentConfig = selectConfig(setConfig)
        print ("Configuration to play : " + ''.join(str(e) for e in currentConfig))
        result = functionInput()
        setConfig = updateSet(currentConfig, result, setConfig)
    print ("Hidden Combination :" + ''.join(str(e) for e in currentConfig))
    return currentConfig
