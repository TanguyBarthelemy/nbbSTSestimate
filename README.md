
<!-- README.md is generated from README.Rmd. Please edit that file -->

# nbbSTSestimate

<!-- badges: start -->
<!-- badges: end -->

Multiprocessing time series imputation by State Space models (incl. low
frequency input)

## Description

Performs in-sample imputation of missing values, as well as for-now- and
back-casting of univariate time series by integrating (or not)
low-frequency input.

## Installation

Running rjd3 packages requires Java 17 or higher. How to set up such a
configuration in R is explained
[here](https://jdemetra-new-documentation.netlify.app/#installing-the-software).

``` r
remotes::install_github("clemasso/nbbSTSestimate")
```

## Usage (2 possibilites)

### 1) Input in R

``` r
library("nbbSTSestimate")

# Examples
## Input: retail data, 3 series
retail_extract <- cbind(
    GroceryStores = rjd3toolkit::retail$GroceryStores,
    BookStores = rjd3toolkit::retail$BookStores,
    ShoeStores = rjd3toolkit::retail$ShoeStores
)
x <- window(retail_extract, c(1990, 1), c(2012, 6), extend = TRUE)
x.lf <- ts(rbind(
    matrix(c(325000, 330000, 7800, 8000, 17500, 18000), nrow = 2, byrow = FALSE),
    aggregate.ts(retail_extract, nfrequency = 1),
    matrix(c(525000, 15000, 27000), nrow = 1)
), start = c(1990, 1), frequency = 1)
## Estimate
rslt1 <- estimateSTS(x, x.lf) # auto procedures for model selection, outlier detection and calendar effect by default
plot(rslt1,"BookStores")
```

<img src="man/figures/README-unnamed-chunk-3-1.png" width="100%" style="display: block; margin: auto;" />

``` r
library("nbbSTSestimate")

## Adding specific input
outliers_input <- data.frame(
    series_name = c("GroceryStores", "GroceryStores", "BookStores", "ShoeStores"),
    outliers = c("LS_2008M12", "AO_2002M04", "auto", "auto")
)
rslt2 <- estimateSTS(
    x,
    x.lf,
    stsmodel = "bsm",
    outliers = "userdefined",
    outliers.df = outliers_input,
    cal.effect = "auto",
    cal.effect.td = "BE",
    cal.effect.easter = TRUE
)
#> Warning: GroceryStores: Some specified outliers are not significant.
plot(rslt2,"BookStores")
```

<img src="man/figures/README-unnamed-chunk-4-1.png" width="100%" style="display: block; margin: auto;" />

### 2) Input in Excel

``` r
# Examples
## Fill structured .xlsx file with your input. See template or vignette for the structure of the Excel file
res <- estimateSTS_fromXLSX(
    path.data = "input_to_R.xlsx",
    is.lf = TRUE,
    conversion = "Sum",
    path.output = "output_R.xlsx"
)
```

## Package Maintenance and contributing

Any contribution is welcome and should be done through pull requests
and/or issues. pull requests should include **updated tests** and
**updated documentation**. If functionality is changed, docstrings
should be added or updated.

## Licensing

The code of this project is licensed under the [European Union Public
Licence
(EUPL)](https://interoperable-europe.ec.europa.eu:443/collection/eupl/eupl-text-eupl-12).
