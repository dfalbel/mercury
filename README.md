# mercury

> Make any web page make sense.

With just one API request, Mercury takes any web article and returns only the 
relevant content — headline, author, body text, relevant images and more — free 
from any clutter. It’s reliable, easy-to-use and free.

This small R package wraps some `httr` code to make it easier to get answers from
the [Mercury Web Parser API](https://mercury.postlight.com/web-parser/).

## Installation

You can install mercury from github with:

``` r
# install.packages("devtools")
devtools::install_github("dfalbel/mercury")
```

To use the `mercury` package you need to set the `MERCURY_KEY` environment variable.
Just create your API key [here](https://mercury.postlight.com/web-parser/) by logging 
in and the run to set the environent variable.

```r
Sys.setenv(MERCURY_KEY = "xxxxxxxxxxxxxxxxxxxxxxxxxxx")
```
With all set you can go to the example below.

## Example

The `mercury` function will return a `tibble` with all information you can get 
with the Mercury Web Parser API. 

``` r
mercury("https://trackchanges.postlight.com/building-awesome-cms-f034344d8ed")
```

It also accepts a list of urls as input.
