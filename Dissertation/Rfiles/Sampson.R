## Main Script
source("/home/pierre/Git/Dissertation/Rfiles/Utils.R")
source("/home/pierre/Git/Dissertation/Rfiles/EM_Algorithm.R")
source("/home/pierre/Git/Dissertation/Rfiles/EM_VariableK.R")
library("lda")
data("sampson")
n <- 18
mat <- sampson[["SAMPLK1"]] + sampson[["SAMPLK2"]] + sampson[["SAMPLK3"]]

print(mat)
mat["ALBERT_16", "AMAND_13"] <- 3
mat["ALBERT_16", "ROMUL_10"] <- 0
rho <- matrix(c(0), 18,3)
for (i in 1:n){
  for (j in 1:K){
    if (mat[i,j] > 0){
      rho[i,mat[i,j]] <- j
    }
    
  }
}

shape <- dim(rho)
n <- shape[1]
K <- shape[2]
p <- 3
a <- 2
b <- 2
Wresult <- EMInference(rho[,1:K],p,a,b, tol = 0.000001)
print(Wresult)