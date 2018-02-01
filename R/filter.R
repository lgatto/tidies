## ## only features
## filter.MSnSet <- function(.data, ...) {
##     tbl <- as_tibble(fData(.data))
##     tbl$.__featureNames__ <- featureNames(.data)
##     res <- filter(tbl, ...)
##     sel <- featureNames(.data) %in% res$.__featureNames__ 
##     .data[sel, ]
## }

## ## only samples
## filter.MSnSet <- function(.data, ...) {
##     tbl <- as_tibble(pData(.data))
##     tbl$.__sampleNames__ <- sampleNames(.data)
##     res <- filter(tbl, ...)
##     sel <- sampleNames(.data) %in% res$.__samplesNames__ 
##     .data[, sel]
## }

## both, but not together
filter.MSnSet <- function(.data, ...) {
    ftbl <- as_tibble(fData(msnset))
    ftbl$.__featureNames__ <- featureNames(.data)
    ptbl <- as_tibble(pData(msnset))
    ptbl$.__sampleNames__ <- sampleNames(.data)
    fres <- tryCatch(filter(ftbl, ...),
                     error = function(e) message("No valid fvarLabels"))
    pres <- tryCatch(filter(ptbl, ...),
                     error = function(e) message("No valid pvarLabels"))
    if (is.null(fres)) fsel <- TRUE
    else fsel <- featureNames(.data) %in% fres$.__featureNames__
    if (is.null(pres)) psel <- TRUE
    else psel <- sampleNames(.data) %in% pres$.__sampleNames__
    .data[fsel, psel]    
}
