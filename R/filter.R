##' @export
##' @examples
##' data(msnset)
##' msnset$group <- c("A", "A", "B", "B")
##' ## filter on feature variables
##' msnset %>%
##'     filter(ProteinAccession == "ENO") %>%
##'     exprs
##'
##' ## filter on pheno variable
##' msnset %>%
##'     filter(group == "A") %>%
##'     exprs %>%
##'     head
##'
##' ## filter on both
##' msnset %>%
##'     filter(group == "A") %>%
##'     filter(ProteinAccession == "ENO") %>%
##'     exprs 
filter.MSnSet <- function(.data, ...) {
    ftbl <- fData(msnset)
    ftbl$.__featureNames__ <- featureNames(.data)
    ptbl <- pData(msnset)
    ptbl$.__sampleNames__ <- sampleNames(.data)
    fres <- try(filter(ftbl, ...), silent = TRUE)
    pres <- try(filter(ptbl, ...), silent = TRUE)
    if (inherits(fres, "try-error")) fsel <- TRUE
    else fsel <- featureNames(.data) %in% fres$.__featureNames__
    if (inherits(pres, "try-error")) psel <- TRUE
    else psel <- sampleNames(.data) %in% pres$.__sampleNames__
    .data[fsel, psel]
}

