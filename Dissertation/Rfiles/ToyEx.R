source("/home/pierre/Git/Dissertation/Rfiles/InferenceCovariates.R")
source("/home/pierre/Git/Dissertation/Rfiles/Utils.R")
source("/home/pierre/Git/Dissertation/Rfiles/GraphModule.R")
library("mcmc")

n <- 10
nbIterations <- 50000
rho <- c(2,3,4,5,6,7,8,9,10,3,4,5,6,7,8,9,10,2)
lK <- c(9,1,1,1,1,1,1,1,1,1)
a <- runif(n, min = -1, max = 1)
b <- runif(n, min = -1, max = 1)
sig <- 0
r <- 0.5
lambda <- rnorm(n*(n-1), mean = 0, sd = 1)
vectParam <- c(a, b, sig, r, lambda)
print(vectParam)

chain <- run_metropolis_MCMC(vectParam, nbIterations, rho, lK)
burnIn = 5000
acceptance = 1-mean(duplicated(chain[-(1:burnIn),]))

par(mfrow = c(2,4))
hist(chain[-(1:burnIn),1],nclass=30,main="Sociability of 1", xlab="Mean value = red line" )
abline(v = mean(chain[-(1:burnIn),1]), col = "red")
hist(chain[-(1:burnIn),2],nclass=30, main="Sociability of 2", xlab="Mean value = red line")
abline(v = mean(chain[-(1:burnIn),2]), col = "red")
hist(chain[-(1:burnIn),n + 1],nclass=30, main="Popularity of 1", xlab="Mean value = red line")
abline(v = mean(chain[-(1:burnIn),n+1]), col = "red")
hist(chain[-(1:burnIn),n + 2],nclass=30, main="Popularity of 2", xlab="Mean value = red line")
abline(v = mean(chain[-(1:burnIn),n+2]), col = "red")

plot(chain[-(1:burnIn),1], type = "l", xlab="True value = red line" , main = "Chain values of a")
plot(chain[-(1:burnIn),2], type = "l", xlab="True value = red line" , main = "Chain values of b")
plot(chain[-(1:burnIn),n+1], type = "l", xlab="True value = red line" , main = "Chain values of sd")
plot(chain[-(1:burnIn),n+2], type = "l", xlab="True value = red line" , main = "Chain values of sd")
# par(mfrow = c(1,1))
# visualizeSimpleGraph(rho, lK)