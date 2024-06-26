% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/main_functions.R
\name{estimateSTS_fromXLSX}
\alias{estimateSTS_fromXLSX}
\title{Estimation of time series by State Space models (incl. low frequency input)
with input coming from a structured XLSX file}
\usage{
estimateSTS_fromXLSX(
  path.data,
  is.lf = TRUE,
  conversion = c("Sum", "Average"),
  path.output = NULL
)
}
\arguments{
\item{path.data}{a string containing the path of the input XLSX file.}

\item{is.lf}{a boolean parameter whether low frequency series should be
considered.}

\item{conversion}{type of consistency between the high frequency series and
the low frequency series (if any)}

\item{path.output}{a string containing the path of the output (which is also
an XLSX file) containing the imputed series.
If the path is NULL, no file is created.}
}
\value{
an object of class "nbb.estimateSTS.output"
}
\description{
See ?estimateSTS for more description. See vignette for explanation about the
required structure of the XLSX file.
}
\examples{
\dontrun{
res<-estimateSTS_fromXLSX(path.data = "input_to_R.xlsx",
                          is.lf = TRUE,
                          conversion = "Sum",
                          path.output = "output_R.xlsx")
}

}
