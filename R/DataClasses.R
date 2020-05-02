setOldClass("grouped_df")

## This class is currently extends MSnSets (that extend eSets
## directly) rather than eSets because the latter are virtual, and
## require some additional plumbing (see for example below).

##' A eSet/MSnSet object with grouped sample or feature variables
##'
##' This object extends the [MSnbase::MSnSet] class by adding slots
##' necessary to record the grouping structure. Objects of class
##' `Grouped_eSet` are created by the `group_by` function. See the
##' vignette for examples.
##'
##' @slot grouped_fData An instance of class `data.frame`
##'     corresponding to a grouped `featureData` slot.
##'     
##' @slot grouped_pData An instance of class `data.frame`
##'     corresponding to a grouped `phenoData` slot.
##' 
##' @export
##' 
##' @aliases Grouped_eSet
##' 
##' @rdname Grouped_eSet
##' 
##' @md
.Grouped_eSet <-
    setClass("Grouped_eSet",
             slots = c(
                 grouped_fData = "data.frame",
                 grouped_pData = "data.frame"),
             contains = "MSnSet")

.group_names <- function(x) 
    colnames(x)[-ncol(x)]

.n_groups <- function(x) 
    nrow(x)

##' @export
##' @rdname Grouped_eSet
##' @param object An `Grouped_eSet` instance.
##' @md
setMethod("show", "Grouped_eSet",
          function(object) {
              callNextMethod()
              n_fd <- .n_groups(object@grouped_fData)
              n_pd <- .n_groups(object@grouped_pData)
              gr_fd <- .group_names(object@grouped_fData)
              gr_pd <- .group_names(object@grouped_pData)
              cat("Groups:\n")
              cat("  features ", paste(gr_fd, collapse = ", "),  "[", n_fd, "]\n")
              cat("  samples  ", paste(gr_pd, collapse = ", "), "[", n_pd, "]\n")
          })

##' @export
setAs("MSnSet", "Grouped_eSet",
      function(from) 
          .Grouped_eSet(
              experimentData = from@experimentData,
              processingData = from@processingData,
              qual = from@qual,
              assayData = from@assayData,
              phenoData = from@phenoData,
              featureData = from@featureData,
              annotation = from@annotation,
              protocolData = from@protocolData))


## ##' @export
## setAs("eSet", "Grouped_eSet",
##       function(from)
##           .Grouped_eSet(
##               experimentData = from@experimentData,
##               assayData = from@assayData,
##               phenoData = from@phenoData,
##               featureData = from@featureData,
##               annotation = from@annotation,
##               protocolData = from@protocolData))

## ##' @export
## setMethod("exprs", signature(object = "eSet"),
##           function(object) assayDataElement(object, "exprs"))

## ##' @export
## t.Grouped_eSet <- function(x) {
##   ans <- .Grouped_eSet(
##              exprs = t(exprs(x)),
##              phenoData = featureData(x),
##              featureData = phenoData(x),
##              annotation = annotation(x),
##              fvars = x@pvars,
##              fdrop = x@pdrop,
##              findices = x@pindices,
##              fgroup_sizes = x@pgroup_sizes,
##              fbiggest_group_size = x@pbiggest_group_size,
##              flabels = x@plabels,
##              pvars = x@fvars,
##              pdrop = x@fdrop,
##              pindices = x@findices,
##              pgroup_sizes = x@fgroup_sizes,
##              pbiggest_group_size = x@fbiggest_group_size,
##              plabels = x@flabels)
##   if (validObject(ans))
##       return(ans)
## }

## ms2df_Grouped_eSet <- function (x, fcols = fvarLabels(x)) {
##     if (is.null(fcols)) {
##         res <- data.frame(exprs(x))
##     }
##     else {
##         sel <- fvarLabels(x) %in% fcols
##         res <- data.frame(exprs(x), fData(x)[, sel])
##         colnames(res)[-seq_len(ncol(x))] <- fcols
##     }
##     return(res)
## }
