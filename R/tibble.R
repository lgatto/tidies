##' @export
##' @rdname tidies
##' @importFrom tidyr gather
##' @param x An object of class `MSnSet`.
##' @param fcols Feature variables to be added. Default is to add all
##'     (i.e. `fvarLabels(x)`). Use `NULL` to add none.
##' @export
##' @md
as_tibble.eSet <- function(x, ..., fcols = fvarLabels(x)) {
    x <- MSnbase::ms2df(x, fcols = fcols)
    if (!is.null(fcols)) res <- tidyr::gather(x, sample, exprs, -fcols)
    else res <- tidyr::gather(x, sample, exprs)
    as_tibble(res)
}
