source("/home/pierre/Git/Dissertation/Rfiles/InferenceCovariates.R")
source("/home/pierre/Git/Dissertation/Rfiles/Utils.R")

n <- 6
K <- 3
p <- 2
a <- 2
b <- 2
rho <- generateNetwork(n,a,b,p,K)
a <- runif(n, min = -1, max = 1)
b <- runif(n, min = -1, max = 1)
sig <- 0
r <- log(0.9)
lambda <- rnorm(n*(n-1), mean = 0, sd = 1)
vectParam <- c(a, b, sig, r, lambda)
print(vectParam)
targetdistrib(vectParam, rho = rho)