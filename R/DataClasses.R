setOldClass("grouped_df")

.Grouped_eSet <-
    setClass("Grouped_eSet",
             slots = c(
                 fvars = "character",
                 fdrop = "logical",
                 findices = "list",
                 fgroup_sizes = "integer",
                 fbiggest_group_size = "integer",
                 flabels = "data.frame",
                 pvars = "character",
                 pdrop = "logical",
                 pindices = "list",
                 pgroup_sizes = "integer",
                 pbiggest_group_size = "integer",
                 plabels = "data.frame"),
             contains = c("eSet", "grouped_df"))

##' @export
setMethod("show", "Grouped_eSet",
          function(object) {
              callNextMethod()
              fgrps <- if (is.null(object@findices)) "?" else length(object@findices)
              pgrps <- if (is.null(object@pindices)) "?" else length(object@pindices)
              cat("Groups:\n")
              cat("  features ", object@fvars, "[", fgrps, "]\n")
              cat("  samples  ", object@pvars, "[", pgrps, "]\n")
          })

##' @export
setAs("eSet", "Grouped_eSet",
      function(from)
          .Grouped_eSet(
              experimentData = from@experimentData,
              assayData = from@assayData,
              phenoData = from@phenoData,
              featureData = from@featureData,
              annotation = from@annotation,
              protocolData = from@protocolData))

##' @export
## setAs("MSnSet", "Grouped_eSet",
##       function(from)
##           .Grouped_eSet(
##               experimentData = from@experimentData,
##               processingData = from@processingData,
##               qual = from@qual,
##               assayData = from@assayData,
##               phenoData = from@phenoData,
##               featureData = from@featureData,
##               annotation = from@annotation,
##               protocolData = from@protocolData))


## @export
setMethod("exprs", signature(object = "eSet"),
          function(object) assayDataElement(object, "exprs"))

## @export
t.Grouped_eSet <- function(x) {
  ans <- .Grouped_eSet(
             exprs = t(exprs(x)),
             phenoData = featureData(x),
             featureData = phenoData(x),
             annotation = annotation(x),
             fvars = x@pvars,
             fdrop = x@pdrop,
             findices = x@pindices,
             fgroup_sizes = x@pgroup_sizes,
             fbiggest_group_size = x@pbiggest_group_size,
             flabels = x@plabels,
             pvars = x@fvars,
             pdrop = x@fdrop,
             pindices = x@findices,
             pgroup_sizes = x@fgroup_sizes,
             pbiggest_group_size = x@fbiggest_group_size,
             plabels = x@flabels)
  if (validObject(ans))
      return(ans)
}

ms2df_Grouped_eSet <- function (x, fcols = fvarLabels(x)) {
    if (is.null(fcols)) {
        res <- data.frame(exprs(x))
    }
    else {
        sel <- fvarLabels(x) %in% fcols
        res <- data.frame(exprs(x), fData(x)[, sel])
        colnames(res)[-seq_len(ncol(x))] <- fcols
    }
    return(res)
}
