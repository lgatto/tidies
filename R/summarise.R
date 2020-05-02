summarise_fData_Grouped_eSet<- function(.data, ...) {
    group_vars <- .group_names(.data@grouped_fData)
    df <- ms2df(.data, fcols = group_vars)
    res <- tidyr::pivot_longer(df,
                               names_to = "sample",
                               values_to = "exprs",
                               -!!group_vars)
    res  <- group_by_(res, "sample", group_vars) %>%
        summarise(...)
    res <- tidyr::pivot_wider(res,
                              names_from = "sample",
                              values_from = ncol(res))
    ans <- readMSnSet2(res, ecol = match(sampleNames(.data), names(res)))
    pData(ans) <- pData(.data)
    fd <- data.frame(res[, -match(sampleNames(.data), names(res)), drop = FALSE])
    featureNames(ans) <- rownames(fd)
    fData(ans) <- fd
    ## how to, or is it relevant to add the rest of the fvarLabels?
    ## Suggestion - add only this that are unique within the groups
    ans
}

summarise_pData_Grouped_eSet <- function(.data, ...) {
    group_vars <- .group_names(.data@grouped_pData)
    df <- ms2df(t(.data), fcols = group_vars)
    ## If the feature names were number (which is the case if the data
    ## was already grouped by features), then they are prefixed with
    ## an `X` in df, which then leads to an error when adding the
    ## original feature data to the newly summarised MSnSet.
    ## colnames(df)[1:nrow(.data)] <- featureNames(.data)
    tb <- tidyr::pivot_longer(df,
                              names_to = "feature",
                              values_to = "exprs",
                              -!!group_vars)
    res <- tb %>%
        group_by_("feature", group_vars) %>%
        summarise(...)
    names(res)[ncol(res)] <- "exprs"
    ans <- tidyr::pivot_wider(res,
                              names_from = group_vars,
                              values_from = "exprs")
    e <- as.matrix(ans[, .data@grouped_pData[[1]]])
    rownames(e) <- ans[["feature"]]
    ans <- new("MSnSet", exprs = e)
    featureNames(ans) <- featureNames(.data)
    fData(ans) <- fData(.data)
    ans
}

##' @export
##' @rdname tidies
##' @importFrom tidyr pivot_longer pivot_wider
summarise.Grouped_eSet <- function(.data, ...) {
    if (nrow(.data@grouped_fData))
        summarise_fData_Grouped_eSet(.data, ...)
    else if (nrow(.data@grouped_pData))
        summarise_pData_Grouped_eSet(.data, ...)
    else .data
}
