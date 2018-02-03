##' @export
##' @examples
##' data(msnset)
##' msnset$group <- c("A", "A", "B", "B")
##'
##' ## group by features
##' msnset %>%
##'     group_by(ProteinAccession)
##'
##' ## group by samples
##' msnset %>%
##'     group_by(group)
##'
##' ## both
##' msnset %>%
##'     group_by(ProteinAccession) %>%
##'     group_by(group)
group_by.MSnSet <- function(.data, ..., add = FALSE) {
    fres <- try(group_by(fData(.data), ..., add = add), silent = TRUE)
    pres <- try(group_by(pData(.data), ..., add = add), silent = TRUE)
    ans <- as(.data, "GroupedMSnSet")
    if (!inherits(fres, "try-error")) {
        ans@fvars <- attr(fres, "vars")
        ans@fdrop <- attr(fres, "drop")
        ans@findices <- attr(fres, "indices")
        ans@fgroup_sizes <- attr(fres, "group_sizes")
        ans@fbiggest_group_size <- attr(fres, "biggest_group_size")
        ans@flabels <- attr(fres, "labels")
    } else if (!inherits(pres, "try-error")) {
        ans@pvars <- attr(pres, "vars")
        ans@pdrop <- attr(pres, "drop")
        ans@pindices <- attr(pres, "indices")
        ans@pgroup_sizes <- attr(pres, "group_sizes")
        ans@pbiggest_group_size <- attr(pres, "biggest_group_size")
        ans@plabels <- attr(pres, "labels")        
    }
    ans
}

