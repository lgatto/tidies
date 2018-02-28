##' @export
##' @rdname tidyms
##' @param add As in the original `dplyr::group_by`function, when ‘add
##'     = FALSE’, the default, `group_by()` will override existing
##'     groups. To add to the existing groups, use `add = TRUE`.
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
