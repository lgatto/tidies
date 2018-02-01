## summarise the expression data based on the fData grouping

## summarise by pData groups -> group_by
## summarise by fData groups -> group_by
## summarise each exprs column

## https://github.com/jtr13/codehelp/blob/master/R/gather.md

msnset$group <- c("A", "A", "B", "B")

x <- msnset %>% group_by(charge)

df <- ms2df(x, fcols = x@fvars)
tb <- gather(df, Sample, Value = sampleNames(msnset))

res <- tb %>%
    group_by_("Sample", x@fvars) %>%
    summarise(X = mean(value, na.rm = TRUE))

## Big question is, when to return an MSnSet (wide), or a tibble
## (long) - there could be an as.MSnSet argument?

spread(res, key = Sample, value = X)

## how to, or is it relevant to add the rest of the fvarLabels?

x <- msnset %>% group_by(group)

df <- ms2df(t(x), fcols = x@pvars)
df$name <- sampleNames(x)

tb <- gather(df, key = Feature, value = Expression, -group, -name)

res <- tb %>% group_by(group, name) %>%
    summarise(X = mean(Expression, na.rm = TRUE))

spread(res, key = name, value = X)
