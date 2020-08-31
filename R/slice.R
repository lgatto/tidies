##' @export
##' @rdname tidies
slice.eSet <- function(.data, ...) {
  ftbl <- fData(.data)
  ftbl$.__featureorder__ <- featureNames(.data) %>% order
  ptbl <- pData(.data)
  ptbl$.__sampleorder__ <- sampleNames(.data) %>% order
  fres <- try(slice(ftbl, ...), silent = TRUE)
  pres <- try(slice(ptbl, ...), silent = TRUE)
  if (inherits(fres, "try-error")) fsel <- TRUE
  else fsel <- order(featureNames(.data)) %in% order(fres$.__featureorder__)
  if (inherits(pres, "try-error")) psel <- TRUE
  else psel <- order(sampleNames(.data)) %in% order(pres$.__sampleorder__)
  .data[fsel, psel]
}
