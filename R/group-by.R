## grouping on feature variables
group_by.MSnSet <- function(.data, ..., add = FALSE) {
    tbl <- as_tibble(fData(.data))
    res <- group_by(tbl, ..., add = add)
    ans <- as(.data, "GroupedMSnSet")
    ans@vars <- attr(res, "vars")
    ans@drop <- attr(x, "drop")
    ans@indices <- attr(x, "indices")
    ans@group_sizes <- attr(x, "group_sizes")
    ans@biggest_group_size <- attr(x, "biggest_group_size")
    ans@labels <- attr(x, "labels")
    ans
}
