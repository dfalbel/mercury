#' Function used to get the Mercury API Key.
#'
#' You need to get yours at [Mercury website](https://mercury.postlight.com/web-parser/)
#'
#' @export
mercury_key <- function() {
  key <- Sys.getenv('MERCURY_KEY')
  if (identical(key, "")) {
    stop("Please set env var MERCURY_KEY to your Mercury personal access token. Go to https://mercury.postlight.com/web-parser/ and get yours.",
         call. = FALSE)
  }
  key
}

get_mercury <- function(url){
  httr::GET(
    "https://mercury.postlight.com/parser",
    query = list(url = url),
    httr::add_headers("x-api-key" = mercury_key())
  )
}

#' @importFrom magrittr %>%
parse_mercury <- function(req){
  req %>%
    httr::content("text", encoding = "UTF-8") %>%
    jsonlite::fromJSON() %>%
    purrr::map_if(is.null, ~NA) %>%
    tibble::as_data_frame()
}


#' Mercury
#'
#' @param urls list of urls to parse with Mercury Web Parser API
#' @return a tibble with many informations about the pages including title, author,
#' date_published, etc.
#'
#' @examples
#' mercury("https://trackchanges.postlight.com/building-awesome-cms-f034344d8ed")
#'
#' @export
#' @importFrom magrittr %>%
mercury <- function(urls){
  urls %>%
    purrr::set_names(urls) %>%
    purrr::map(get_mercury) %>%
    purrr::map_df(parse_mercury, .id = "url")
}


