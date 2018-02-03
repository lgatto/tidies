summarise_fData_GroupedMSnSet <- function(.data, ...) {
    df <- ms2df(x, fcols = .data@fvars)
    res <- df %>% gather(sample,
                         exprs,
                         -!!.data@fvars)
    res <- res %>%
        group_by_("sample", .data@fvars) %>% 
        summarise(...)
    ans <- spread(res, sample, ncol(res))
    ans <- readMSnSet2(ans, ecol = match(sampleNames(.data), names(ans)))
    pData(ans) <- pData(.data)
    featureNames(ans) <- .data@flabels[[1]]
    ## how to, or is it relevant to add the rest of the fvarLabels?
    ## Suggestion - add only this that are unique within the groups
    ans
}

summarise_pData_GroupedMSnSet <- function(.data, ...) {
    df <- ms2df(t(.data), fcols = .data@pvars)
    tb <- gather(df, feature, exprs, -!!.data@pvars)
    res <- tb %>%
        group_by_("feature", .data@pvars) %>%
        summarise(...)
    names(res)[ncol(res)] <- "exprs"
    ans <- spread_(res, .data@pvars, "exprs")
    e <- as.matrix(ans[, .data@plabels[[1]]])    
    rownames(e) <- ans[["feature"]]
    ans <- new("MSnSet", exprs = e)
    fData(ans) <- fData(.data)
    ans
}

##' @export
summarise.GroupedMSnSet <- function(.data, ...) {
    if (length(.data@fvars)) 
        summarise_fData_GroupedMSnSet(.data, ...)
    else if (length(.data@pvars))
        summarise_pData_GroupedMSnSet(.data, ...)
    else .data
}


## msnset$group <- c("A", "A", "B", "B")
## msnset$group2 <- c("A", "A", "B", "C")


## msnset %>% group_by(charge) %>%
##     summarise(median(exprs, na.rm = TRUE)) %>% exprs

## msnset %>% group_by(ProteinAccession) %>%
##     summarise(median(exprs, na.rm = TRUE)) %>% exprs


## msnset %>% group_by(group) %>%
##     summarise(mean(exprs, na.rm = TRUE)) %>% exprs %>% head


## msnset %>%
##     group_by(charge) %>%
##     summarise(mean(exprs)) %>%
##     group_by(group) %>%
##     summarise(max(exprs, na.rm = TRUE)) %>%
##     exprs
