#' List Available IRPF Data Sections
#'
#' This function returns a table containing all the available data sections
#' that can be retrieved from the Great Numbers of Brazilian Individual Income Tax (IRPF) through this package.
#'
#' @return A tibble with two columns: \code{secao} (the key to be used in other functions)
#' and \code{descricao} (a brief explanation of the data).
#' @export
#'
#' @examples
#' get_sections()

get_sections <- function() {
  message("Fetching available sections for IRPF data...")
  return(irpf_sections_catalog)
}
