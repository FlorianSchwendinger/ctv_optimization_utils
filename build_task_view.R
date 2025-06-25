# install.packages("ctv")
library("ctv")

ifi <- normalizePath("../Optimization/Optimization.md")
x <- read.ctv(ifi)
print(x)
ctv2html(x)
browseURL("Optimization.html")


