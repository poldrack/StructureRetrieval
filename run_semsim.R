# using example from simsem documentation

library(lavaan)

mkdata=function(n=522){
popModel <- "
    f1 =~ 1*y1 + 0.6*y2 + 0.7*y3
f2 =~ 1*y4 + 1.1*y5 + 0.9*y6
f3 =~ 1*y7 + 1.2*y8 + 1.1*y9
f4 =~ 1*y10 + 1.2*y11 + 1.1*y12
f5 =~ 1*y13 + 1.2*y14 + 1.1*y15
f6 =~ 1*y16 + 1.2*y17 + 1.1*y18


f1 ~~ 0.8*f1
f2 ~~ 0.9*f2
f3 ~~ 0.4*f3
f1 ~~ 0.4*f2
f1 ~~ 0.2*f3
f2 ~~ 0.3*f3
y1 ~~ 0.5*y1
y2 ~~ 1.1*y2
y3 ~~ 0.8*y3
y4 ~~ 0.4*y4
y5 ~~ 0.4*y5
y6 ~~ 0.8*y6
y7 ~~ 0.8*y7
y8 ~~ 0.5*y8
y9 ~~ 0.6*y9
y10 ~~ 0.6*y10
y11 ~~ 0.6*y11
y12 ~~ 0.6*y12
y13 ~~ 0.6*y13
y14 ~~ 0.6*y14
y15 ~~ 0.6*y15
y16 ~~ 0.6*y16
y17 ~~ 0.6*y17
y18 ~~ 0.6*y18
"
analyzeModel <- "
    f1 =~ y1 + y2 + y3
f2 =~ y4 + y5 + y6
f3 =~ y7 + y8 + y9
f4 =~ y10 + y11 + y12
f5 =~ y13 + y14 + y15
f6 =~ y16 + y17 + y18
"

s=simulateData(popModel,sample.nobs=n)
return(s)
}

noisesd=1
foo=mkdata() + noisesd*matrix(rnorm(522*18),ncol=18)
dimest=c()
for (i in 1:100){
  rs=sample.int(dim(foo)[1],replace=TRUE)
  rsdata=foo[rs,]
  p=fa.parallel(rsdata,plot=FALSE)
  dimest=c(dimest,p$nfact)
}
fa.parallel(foo)
print(mean(dimest))
