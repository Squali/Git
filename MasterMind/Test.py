from Utils import createPartition
from random import sample

# Test Module


def main():
    l = list(range(8))
    lSample1 = sample(l, 4)
    lSample2 = sample(l, 4)
    setSample = [sample(l, 4) for i in range(20)]
    print lSample1
    print setSample
    print createPartition(lSample1, result, setSample)
    return
