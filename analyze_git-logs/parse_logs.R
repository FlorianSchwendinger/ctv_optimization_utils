library("jsonlite")

df <- fromJSON("../git_logs.json")
head(df)

df[grep("gafit", df[["subject"]]),]

k <- grep("(archived|removed)", df[["subject"]], ignore.case = TRUE)
archived <- df[k, ]
archived[["pkg"]] <- gsub("\\s.*", "", archived[["subject"]])
archived <- archived[!duplicated(archived[["pkg"]]), ]
head(archived)
archived[["subject"]]


pkgs_cran <- available.packages()
pkgs_cran <- pkgs_cran[, "Package"]
pkgs_cran

k <- tolower(archived[["pkg"]]) %in% tolower(pkgs_cran)
pkgs[k]

archived[k, ]


setwd("../Optimization")
dir()

restore_pkgs <- c("optimsimplex", "neldermead", "lsei", "gafit", "sna")


z <- archived[archived[["pkg"]] %in% restore_pkgs, c("pkg", "author")]
z[["date"]] <- z[["author"]][["date"]]
z[["author"]] <- NULL
rownames(z) <- NULL
z


i <- 1L

pkg <- restore_pkgs[i]
j <- which(pkg == archived[["pkg"]])[1L]
cmd <- sprintf("git difftool %s %s", archived[j, "commit"], archived[j, "parent"])
system(cmd)

i <- i + 1L


