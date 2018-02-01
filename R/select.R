## select feature variables
select.MSnSet <- function(.data, ...) {
    tbl <- as_tibble(fData(.data))
    res <- select(tbl, ...)
    fData(.data) <- fData(.data)[, colnames(res)]
    .data
}

