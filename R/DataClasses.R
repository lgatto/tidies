.GroupedMSnSet <-
    setClass("GroupedMSnSet",
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
setMethod("show", "GroupedMSnSet",
          function(object) {
              callNextMethod()
              fgrps <- if (is.null(object@findices)) "?" else length(object@findices)
              pgrps <- if (is.null(object@pindices)) "?" else length(object@pindices)
              ## cat("Object of class 'GroupedMSnSet'\n")
              cat("Groups:\n")
              cat("  features ", object@fvars, "[", fgrps, "]\n")
              cat("  samples  ", object@pvars, "[", pgrps, "]\n")
          })

##' @export
setAs("MSnSet", "GroupedMSnSet",
      function(from) 
          .GroupedMSnSet(
              experimentData = from@experimentData,
              processingData = from@processingData,
              qual = from@qual,
              assayData = from@assayData,
              phenoData = from@phenoData,
              featureData = from@featureData,
              annotation = from@annotation,
              protocolData = from@protocolData))
