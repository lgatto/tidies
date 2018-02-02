## summarise the expression data based on the fData grouping

## summarise by pData groups -> group_by
## summarise by fData groups -> group_by
## summarise each exprs column

## https://github.com/jtr13/codehelp/blob/master/R/gather.md


summarise_fData_MSnSet <- function(.data, ...) {
    df <- ms2df(x, fcols = .data@fvars)
    tb <- gather(df, Sample, Value = sampleNames(msnset))
    res <- tb %>%
        group_by_("Sample", .data@fvars) %>%
        summarise(...)
    ans <- spread_(res, key = "Sample", value = names(res)[ncol(res)])
    ans <- readMSnSet2(ans, ecol = match(sampleNames(.data), names(ans)))
    pData(ans) <- pData(.data)
    ## how to, or is it relevant to add the rest of the fvarLabels?
    ## Suggestion - add only this that are unique within the groups
    ans
}


tmp <- msnset %>% group_by(charge) %>%
    summarise_fData_MSnSet(mean(charge, na.rm = TRUE)) 


exprs(tmp)
fData(tmp)

summarise_pData_MSnSet <- function(.data, ...) {
    df <- ms2df(t(x), fcols = x@pvars)    
    df$name <- sampleNames(x)
    tb <- gather(df, key = Feature, value = Expression, -group, -name)
    res <- tb %>% group_by(group, Feature) %>%
        summarise(X = mean(Expression, na.rm = TRUE))
    
    ans <- spread(res, key = group, value = X)
    e <- as.matrix(ans[, .data@plabels[[1]]])
    rownames(e) <- ans[["Feature"]]
    new("MSnSet", exprs = e)
}

msnset$group <- c("A", "A", "B", "B")

tmp <- msnset %>% group_by(group) %>%
    summarise_pData_MSnSet(mean(group, na.rm = TRUE))
