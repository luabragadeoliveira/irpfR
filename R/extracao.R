#' Download and Clean IRPF Data
#'
#' This function connects to the Brazilian Federal Revenue (RFB) open data server,
#' downloads the CSV for the requested section, and performs data cleaning
#' (standardizing names, pivoting to tidy format, and adjusting currency scales).
#'
#' @param section A string representing the section name (e.g., "bens_e_direitos").
#'
#' @return A tidy tibble with columns: \code{ano_calendario}, \code{atributo}, and \code{valor}.
#' @export
#'
#' @examples
#' \donttest{
#'  df <- get_irpf("bens_e_direitos")
#'  head(df)
#' }

get_irpf <- function(section) {
  target_url <- map_url_irpf(section)

  message("Accessing Brazilian Federal Revenue database for section: '", section, "'...")

  temp_file <- tempfile(fileext = ".csv")
  req <- httr2::request(target_url)

  message("Downloading file (this may take a while depending on your connection)...")
  tryCatch({
    httr2::req_perform(req, path = temp_file)
  }, error = function(e) {
    stop("Failed to download data from RFB.\nOriginal error: ", e$message, call. = FALSE)
  })

  message("Download complete! Cleaning and structuring data...")

  raw_data <- suppressMessages({
    readr::read_csv2(
      temp_file,
      locale = readr::locale(encoding = "UTF-8", decimal_mark = ",", grouping_mark = "."),
      na = c("", "NA", "-", "*", "X"),
      show_col_types = FALSE
    )
  })

  clean_data <- raw_data %>%
    janitor::clean_names() %>%

    tidyr::pivot_longer(
      cols = -c(dplyr::any_of("ano_calendario"), where(is.character)),
      names_to = "atributo",
      values_to = "valor",
      values_drop_na = TRUE
    ) %>%

    dplyr::mutate(
      valor = dplyr::if_else(
        grepl("^quantidade", .data$atributo),
        .data$valor,
        .data$valor * 1e6
      )
    )

  message("Data ready for analysis!")

  return(clean_data)
}
