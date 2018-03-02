setOldClass("grouped_df")

## This class is currently extends MSnSets (that extend eSets
## directly) rather than eSets because the latter are virtual, and
## require some additional plumbing (see for example below).

##' A eSet/MSnSet object with grouped sample or feature variables
##'
##' This object extends the [MSnbase::MSnSet] class by adding slots
##' necessary to record the grouping structure. These additional slots
##' are inherited from the [dplyr::grouped_df] class.
##'
##' Objects of class `Grouped_eSet` are created by the `group_by`
##' function. See the vignette for examples.
##'
##' @slot fvars a `character` vector or a `list` of grouping feature
##'     variables.
##' @slot fdrop a logical (default is `TRUE`) to preserve all feature
##'     variable factor levels, even those without data.
##' @slot findices indices defining the feature groups.
##' @slot fgroup_sizes an `integer` defining the sizes of the feature
##'     groups.
##' @slot fbiggest_group_size an `integer` defining the biggest
##'     feature group size.
##' @slot flabels a `data.frame` defining the feature groups and
##'     levels.
##' @slot pvars a `character` vector or a `list` of grouping sample
##'     variables.
##' @slot pdrop a logical (default is `TRUE`) to preserve all sample
##'     variable factor levels, even those without data.
##' @slot pindices indices defining the sample groups.
##' @slot pgroup_sizes an `integer` defining the sizes of the sample
##'     groups.
##' @slot pbiggest_group_size an `integer` defining the biggest sample
##'     group size.
##' @slot plabels a `data.frame` defining the sample groups and
##'     levels.
##' @export
##' @aliases Grouped_eSet
##' @rdname Grouped_eSet
##' @md
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
             contains = c("MSnSet", "grouped_df"))


##' @export
##' @rdname Grouped_eSet
##' @param object An `Grouped_eSet` instance.
##' @md
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
