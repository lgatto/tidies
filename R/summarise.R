summarise_fData_Grouped_eSet<- function(.data, ...) {
    df <- ms2df(.data, fcols = .data@fvars)
    res <- df %>% tidyr::gather(sample,
                                exprs,
                                -!!.data@fvars)
    res <- res %>%
        group_by_("sample", .data@fvars) %>%
        summarise(...)
    ans <- tidyr::spread(res, sample, ncol(res))
    ans <- readMSnSet2(ans, ecol = match(sampleNames(.data), names(ans)))
    pData(ans) <- pData(.data)
    featureNames(ans) <- .data@flabels[[1]]
    ## how to, or is it relevant to add the rest of the fvarLabels?
    ## Suggestion - add only this that are unique within the groups
    ans
}

summarise_pData_Grouped_eSet <- function(.data, ...) {
    df <- ms2df(t(.data), fcols = .data@pvars)
    ## If the feature names were number (which is the case if the data
    ## was already grouped by features), then they are prefixed with
    ## an `X` in df, which then leads to an error when adding the
    ## original feature data to the newly summarised MSnSet.
    colnames(df)[1:nrow(.data)] <- featureNames(.data)
    feature <- NULL
    tb <- tidyr::gather(df, feature, exprs, -!!.data@pvars)
    res <- tb %>%
        group_by_("feature", .data@pvars) %>%
        summarise(...)
    names(res)[ncol(res)] <- "exprs"
    ans <- tidyr::spread_(res, .data@pvars, "exprs")
    e <- as.matrix(ans[, .data@plabels[[1]]])
    rownames(e) <- ans[["feature"]]
    ans <- new("MSnSet", exprs = e)
    fData(ans) <- fData(.data)
    ans
}

##' @export
##' @rdname tidies
##' @importFrom tidyr gather spread
summarise.Grouped_eSet <- function(.data, ...) {
    if (length(.data@fvars))
        summarise_fData_Grouped_eSet(.data, ...)
    else if (length(.data@pvars))
        summarise_pData_Grouped_eSet(.data, ...)
    else .data
}
