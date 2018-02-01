## ## grouping on feature variables
## group_by_fData_MSnSet <- function(.data, ..., add = FALSE) {
##     tbl <- as_tibble(fData(.data))
##     res <- group_by(tbl, ..., add = add)
##     ans <- as(.data, "GroupedMSnSet")
##     ans@fvars <- attr(res, "vars")
##     ans@fdrop <- attr(res, "drop")
##     ans@findices <- attr(res, "indices")
##     ans@fgroup_sizes <- attr(res, "group_sizes")
##     ans@fbiggest_group_size <- attr(res, "biggest_group_size")
##     ans@flabels <- attr(res, "labels")
##     ans
## }

## ## grouping on samples
## group_by_pData_MSnSet <- function(.data, ..., add = FALSE) {
##     tbl <- as_tibble(pData(.data))
##     res <- group_by(tbl, ..., add = add)
##     ans <- as(.data, "GroupedMSnSet")
##     ans@pvars <- attr(res, "vars")
##     ans@pdrop <- attr(res, "drop")
##     ans@pindices <- attr(res, "indices")
##     ans@pgroup_sizes <- attr(res, "group_sizes")
##     ans@pbiggest_group_size <- attr(res, "biggest_group_size")
##     ans@plabels <- attr(res, "labels")
##     ans
## }

group_by.MSnSet <- function(.data, ..., add = FALSE) {
    ftbl <- as_tibble(fData(.data))
    ptbl <- as_tibble(pData(.data))
    fres <- try(group_by(ftbl, ..., add = add), silent = TRUE)
    pres <- try(group_by(ptbl, ..., add = add), silent = TRUE)
    ans <- as(.data, "GroupedMSnSet")
    if (!inherits(fres, "try-error")) {
        ans@fvars <- attr(fres, "vars")
        ans@fdrop <- attr(fres, "drop")
        ans@findices <- attr(fres, "indices")
        ans@fgroup_sizes <- attr(fres, "group_sizes")
        ans@fbiggest_group_size <- attr(fres, "biggest_group_size")
        ans@flabels <- attr(fres, "labels")
    } else {
        ans@pvars <- attr(pres, "vars")
        ans@pdrop <- attr(pres, "drop")
        ans@pindices <- attr(pres, "indices")
        ans@pgroup_sizes <- attr(pres, "group_sizes")
        ans@pbiggest_group_size <- attr(pres, "biggest_group_size")
        ans@plabels <- attr(pres, "labels")        
    }
    ans
}
