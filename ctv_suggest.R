# remotes::install_github("DylanDijk/CTVsuggest")
# install.packages(c("xml2", "rdflib"))
library("CTVsuggest")
library("xml2")
library("rdflib")
source("ctv_ignore.R")  # defines `ignore` variable


cran_package_description <- function(pkg) {
    url <- sprintf("https://cran.r-project.org/web/dcmeta/%s.xml", pkg)
    xml <- read_xml(url)
    values <- lapply(xml_children(xml), xml_text)
    names(values) <- sapply(xml_children(xml), xml_name)
    values
}


args(CTVsuggest)
pkgs <- CTVsuggest(taskview = "Optimization", n = 10, ignore = ignore)
pkgs

pkg <- "mooplot"
details <- lapply(pkgs$Packages, cran_package_description)
descr <- setNames(lapply(details, "[[", "description"), pkgs$Packages)
descr

md_file <- "ctv_suggestions.md"
doc <- c("# Optimization Task View Suggestions\n\n",
         "This file contains suggestions for packages in the Optimization task view.\n\n")
for (i in seq_along(descr)) {
   doc <- c(doc, sprintf("## %s\n%s\n\n", names(descr)[i], descr[[i]])) 
}
writeLines(doc, md_file)


# new packages
writeLines(deparse(pkgs$Packages))

writeLines(sprintf("- [ ] %s", pkgs$Packages))

