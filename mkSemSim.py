"""
use lavaan simulateData function to generate data from example CFA model
"""

from rpy2.robjects.packages import SignatureTranslatedAnonymousPackage
import numpy

def mkSimSem(variances=[0.5,1.1,0.8,0.4,0.4,0.8,0.8,0.5,0.6]):
    string = """
    library(lavaan)
    mkdata=function(n){
    popModel <- "
        f1 =~ 1*y1 + 0.6*y2 + 0.7*y3
    f2 =~ 1*y4 + 1.1*y5 + 0.9*y6
    f3 =~ 1*y7 + 1.2*y8 + 1.1*y9
    f1 ~~ 0.8*f1
    f2 ~~ 0.9*f2
    f3 ~~ 0.4*f3
    f1 ~~ 0.4*f2
    f1 ~~ 0.2*f3
    f2 ~~ 0.3*f3
    y1 ~~ %f*y1
    y2 ~~ %f*y2
    y3 ~~ %f*y3
    y4 ~~ %f*y4
    y5 ~~ %f*y5
    y6 ~~ %f*y6
    y7 ~~ %f*y7
    y8 ~~ %f*y8
    y9 ~~ %f*y9
    "
    analyzeModel <- "
        f1 =~ y1 + y2 + y3
    f2 =~ y4 + y5 + y6
    f3 =~ y7 + y8 + y9
    "

    s=simulateData(popModel,sample.nobs=n)
    return(s)
    }"""%tuple((i for i in variances))

    return SignatureTranslatedAnonymousPackage(string, "semsimdata")

def simulateData(n=200):
    semsimdata=mkSimSem()
    d=semsimdata.mkdata(n)
    return numpy.array(d)
