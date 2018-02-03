##' @export
##' @examples
##'
##' data(msnset)
##' msnset$group <- c("A", "A", "B", "B")
##' msnset %>%
##'     arrange(desc(group)) %>%
##'     pData
##' 
##' msnset %>%
##'     select(charge) %>%
##'     fData %>% head
##' msnset %>%
##'     arrange(charge) %>%
##'     select(charge) %>%
##'     fData %>% head
arrange.MSnSet <- function(.data, ...) {
    fd <- fData(.data)
    fd$.__featureNames__ <- featureNames(.data)
    fd <- try(arrange(fd, ...), silent = TRUE)
    pd <- pData(.data)
    pd$.__sampleNames__ <- sampleNames(.data)
    pd <- try(arrange(pd, ...), silent = TRUE)
    if (!inherits(fd, "try-error")) {
        .data <- .data[fd$.__featureNames_, ]
        rownames(fd) <- fd$.__featureNames__
        fd$.__featureNames__ <- NULL
        fData(.data) <- fd
    } else if (!inherits(pd, "try-error")) {
        .data <- .data[, pd$.__sampleNames__]
        rownames(pd) <- pd$.__sampleNames__
        pd$.__sampleNames__ <- NULL
        pData(.data) <- pd
    }
    .data
}
