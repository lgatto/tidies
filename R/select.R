##' @export
##' @rdname tidyms
select.MSnSet <- function(.data, ...) {
    ftbl <- try(select(fData(.data), ...), silent = TRUE)
    ptbl <- try(select(pData(.data), ...), silent = TRUE)
    if (!inherits(ftbl, "try-error")) {
        fData(.data) <- ftbl
    } else if (!inherits(ptbl, "try-error")) {
        pData(.data) <- ptbl
    }
    .data
}
