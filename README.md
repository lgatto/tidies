# A Grammar of Data Manipulation for Quantitative Proteomics

The `tidyms` package implements tidy principles as defined in
the [tidyverse](https://www.tidyverse.org/) packages to omics-type
data classes, with (currently at least), an emphasis on quantitative
proteomics data.

Details and examples are provides in the vignette.

## Installation

First, install the [Bioconductor](https://bioconductor.org/)
dependencies. If you haven't installed any Bioconductor packages
before, bootstrap the package installations with

```r
## try http:// if https:// URLs are not supported
source("https://bioconductor.org/biocLite.R")
biocLite()
```

```r
library("BiocInstaller")
biocLite("MSnbase")
```

In case it isn't installed yet, please install `dplyr` and `tidyr`:

```r
install.packages(c("dplyr", "tidyr"))
```

You can now install the `tidyms` package from github with:

```r
biocLite("lgatto/tidyms")
```

## Questions

Please ask question, report bugs and suggest improvememt by opening a
GitHub [issue](https://github.com/lgatto/tidyms/issues).

## Contributing

Contributions to the package are more than welcome. If you want to
contribute to this package, you should follow the same conventions as
the rest of the functions. Please do get in touch (preferable opening
a [github issue](https://github.com/lgatto/tidyms/issues/)) to discuss
any suggestions.

Please note that this project is released with
a
[Contributor Code of Conduct](https://github.com/lgatto/tidyms/blob/master/CONDUCT.md). By
participating in this project you agree to abide by its terms.
