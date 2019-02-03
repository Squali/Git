## Test POsterior EM
source("/home/pierre/Git/Dissertation/Rfiles/Utils.R")
source("/home/pierre/Git/Dissertation/Rfiles/EM_Algorithm.R")
source("/home/pierre/Git/Dissertation/Rfiles/EM_VariableK.R")
n <- 20
K <- 5
p <- 4
a <- 2
b <- 2
rho <- generateNetwork(n,a,b,p,K)
rhoV <- as.vector(t(rho))
print(rho)
print(rhoV)
lK <- rep(c(K), times = n)
fit <- EMInference(rho,p,a,b, tol = 0.1)
fitV <- EMInferenceV(rho, lK, p,a,b, tol = 0.1)
lPost <- fit[["postList"]]
lPostV <- fitV[["postList"]]
plot((1:length(lPost))/100, lPost, type="l", xlab="Number of epochs", ylab="Log Posterior")
lines((1:length(lPostV))/100, lPostV, type="l", xlab="Number of epochs", ylab="Log Posterior")

# for (i in 1:100){
#   fit <- EMInference(rho,p,a,b, tol = 0.1)
#   lPost <- fit[["postList"]]
#   lines((1:length(lPost))/100, lPost)
# }