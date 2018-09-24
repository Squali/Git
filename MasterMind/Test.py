from Utils import compare
from random import sample

##Test Module
def main():
    l = list(range(8))
    lSample1 = sample(l, 4)
    lSample2 = sample(l, 4)
    print lSample1
    print lSample2
    print compare(lSample1, lSample2)
    return 1
