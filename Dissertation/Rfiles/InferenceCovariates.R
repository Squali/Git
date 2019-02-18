library("MASS", lib.loc="/usr/lib/R/library")
library("mvtnorm", lib.loc="~/R/x86_64-pc-linux-gnu-library/3.5")
library("invgamma")
## First, there will be no covariates beta = 0

# s = prior in beta, a, b. r = prior in the inverse wishart
loglikelihood <- function(lambda, rho) {
  shape <- dim(rho)
  n <- shape[1]
  K <- shape[2]
  remove(shape)
  
  Delta <- matrix(rowSums(lambda), n, K)
  for (i in 1:n){
    for (j in 2:K){
      Delta[i,j] <- Delta[i,j-1] - lambda[i, rho[i,j-1]]
    }
  }
  interm <- matrix(0,n,K)
  for (i in 1:n){
    for(j in 1:K){
      interm[i,j] <- lambda[i,rho[i,j]]
    }
    }
  L <- sum(sum(log(Delta)) + sum(log(interm)))
}
data <- function(){
  n <- 6
  priorParam <- 10**(5)
  priorSigma <- 0.01
  priorParamWi <- 10**(5)
  lengthCov <- 0
  return(list("n" = n, "priorParam" = priorParam, "priorParamWi" = priorParamWi, "lengthCov" = lengthCov, "priorSigma" = priorSigma))
}

#vecParam = [a, b, sigma, rho, lambda, beta] Here lambda are log(lambda) and without the diagonal and sigma and rho are the log of the real parameters
targetdistrib <- function(vecParam, rho = rho) {
  shape <- dim(rho)
  K <- shape[2]
  dat <- data()
  n <- shape[1]
  pr <- dat[["priorParam"]]
  prwi <- dat[["priorParamWi"]]
  prSigma <- dat[["priorSigma"]]
  lengthCov <- dat[["lengthCov"]]
  a <- vecParam[1:n]
  b <- vecParam[(n+1):(2*n)]
  sig <- vecParam[(2*n + 1)]
  realr <- vecParam[(2*n + 2)]
  realSigma <- exp(sig)
  lambdavec <- matrix(vecParam[(2*n + 3):(2*n + 2 + n*(n-1))], n, (n-1), byrow = TRUE)
  interm <- matrix(0,n,n)
  for (i in 1:n){
    interm[i,-i] <- lambdavec[i,]
  }
  lambda <- interm
  condBeta <- 0
  if (lengthCov != 0) {
    beta <- vecParam[-1:-(2*n + 3 + n*(n-1))]
    condBeta <- -sum((beta**2)/(2*(pr**2)))
  }
  
  #Computation prio
  print(condBeta)
  prior <- -sum((a**2)/(2*(pr**2))) - sum((b**2)/(2*(pr**2))) + condBeta - 1.01*sig - 1.01/realSigma
  #-10*(realSigma) - (5/2)*log(1-(realr)**2) - (prwi/((realSigma**2)*(1-r**2))) - r**2/(2*((prSigma)**2)) -sig**2/(2*((prSigma)**2))
  print("prior")
  print(prior)
  # Computation 2nd term
  summation <- 0
  for (i in (1:(n-1))) {
    for (j in (i+1):n) {
      summation <- summation + dmvnorm(c(lambda[i,j], lambda[j,i]), mean = c(a[i] + b[j], a[j] + b[i]),sigma= matrix(c(realSigma**2, (realSigma**2)*realr, (realSigma**2)*realr, realSigma**2), 2,2), log=TRUE)
    }
  }
  print("2nd term")
  print(summation)
  
  #Computation 3nd term
  lambdaExp <- exp(lambda)
  Delta <- matrix(rowSums(lambdaExp), n, K)
  for (i in 1:n){
    for (j in 2:K){
      Delta[i,j] <- Delta[i,j-1] - lambdaExp[i, rho[i,j-1]]
    }
  }
  
  interm <- matrix(0,n,K)
  for (i in 1:n){
    for(j in 1:K){
      interm[i,j] <- lambda[i,rho[i,j]]
    }
  }
  thirdTerm <- -sum(log(Delta)) + sum(interm)
  print(thirdTerm)
  print("result target")
  print(prior + summation + thirdTerm)
  return(prior + summation + thirdTerm)
}


proposalfunction <- function(vecParam){
  dat <- data()
  n <- dat[["n"]]
  pr <- dat[["priorParam"]]
  prwi <- dat[["priorParamWi"]]
  prSigma <- dat[["priorSigma"]]
  lengthCov <- dat[["lengthCov"]]
  a <- vecParam[1:n]
  b <- vecParam[(n+1):(2*n)]
  l1 = vecParam[1:(2*n)]
  l = rnorm(2*n, mean = l1, sd = rep(1, 2*n))
  l2 = rinvgamma(1, shape = prSigma, rate = prSigma)
  l3 = runif(1)
  return(c(l,l2,l3))
}

run_metropolis_MCMC <- function(startvalue, iterations, rho){
  d <- length(startvalue)
  chain = array(dim = c(iterations+1,d))
  chain[1,] = startvalue
  for (i in 1:iterations){
    proposal = proposalfunction(chain[i,])
    
    probab = exp(targetdistrib(proposal, rho = rho) - targetdistrib(chain[i,], rho = rho))
    print(targetdistrib(proposal, rho = rho))
    if (runif(1) < probab){
      chain[i+1,] = proposal
    }else{
      chain[i+1,] = chain[i,]
    }
  }
  return(chain)
}

s