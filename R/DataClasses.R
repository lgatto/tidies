.GroupedMSnSet <- setClass("GroupedMSnSet",
         slots = c(vars = "character",
                   drop = "logical",
                   indices = "list",
                   group_sizes = "integer",
                   biggest_group_size = "integer",
                   labels = "data.frame"),
         contains = c("MSnSet", "grouped_df"))

setMethod("show", "GroupedMSnSet",
          function(object) {
              grps <- if (is.null(object@indices)) "?" else length(object@indices)
              ## cat("Object of class 'GroupedMSnSet'\n")
              cat("Groups: ", object@vars, "[", grps, "]\n")
              callNextMethod()
          })

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
