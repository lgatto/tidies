filter.MSnSet <- function(.data, ...) {
    tbl <- as_tibble(fData(.data))
    tbl$.__featureNames__ <- featureNames(.data)
    res <- filter(tbl, ...)
    sel <- featureNames(.data) %in% res$.__featureNames__ 
    .data[sel, ]
}
