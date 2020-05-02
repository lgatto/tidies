##' @export
##' @rdname tidies
##' @param add As in the original `dplyr::group_by`function, when ‘add
##'     = FALSE’, the default, `group_by()` will override existing
##'     groups. To add to the existing groups, use `add = TRUE`.
group_by.eSet <- function(.data, ..., add = FALSE) {
    fres <- try(group_by(fData(.data), ..., add = add), silent = TRUE)
    pres <- try(group_by(pData(.data), ..., add = add), silent = TRUE)
    ans <- as(.data, "Grouped_eSet")
    if (!inherits(fres, "try-error")) {
        ans@grouped_fData <- attr(fres, "groups")
    } else if (!inherits(pres, "try-error")) {
        ans@grouped_pData <- attr(pres, "groups")
    } else {
        warning("No variables for grouping found.")
    }
    ans
}
