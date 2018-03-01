##' @export
##' @rdname tidies
filter.eSet <- function(.data, ...) {
    ftbl <- fData(.data)
    ftbl$.__featureNames__ <- featureNames(.data)
    ptbl <- pData(.data)
    ptbl$.__sampleNames__ <- sampleNames(.data)
    fres <- try(filter(ftbl, ...), silent = TRUE)
    pres <- try(filter(ptbl, ...), silent = TRUE)
    if (inherits(fres, "try-error")) fsel <- TRUE
    else fsel <- featureNames(.data) %in% fres$.__featureNames__
    if (inherits(pres, "try-error")) psel <- TRUE
    else psel <- sampleNames(.data) %in% pres$.__sampleNames__
    .data[fsel, psel]
}
