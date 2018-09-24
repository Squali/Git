# MasterMind Project

## Objectives
Create a tool to guide user in order to perform the best performance while playing the Mastermind.

## Rules
We will assume the colours of the possibilities are all different.

## Functioning
The algorithm works as follow :
Given an Hidden Combination of colours the user try to find, the algorithm suggests, step by step, a combination that Minimizes the Worst Case scenario.

In other terms, when a combination is chosen, the potential results partition the set of possible solutions corresponding to the configurations that give the same result. The algorithm gives the combination that minimizes the cardinal of the biggest set of the partition.

The algorithm then stops when the right combination is find, or when only one final combination lies in the followinf partion sets.
