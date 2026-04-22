#' Get Metadata for a Specific IRPF Section
#'
#' Returns a detailed dictionary of all attributes (columns) present in a
#' specific IRPF data section.
#'
#' @param section A string representing the section name (see \code{get_sections()}).
#'
#' @return A tibble with columns \code{atributo} and \code{descricao}.
#' @export
#'
#' @examples
#' get_metadata("bens_e_direitos")

get_metadata <- function(section) {
  meta <- irpf_metadata_storage[[section]]

  if (is.null(meta)) {
    stop("Metadata not found for section: ", section,
         ". Run `get_sections()` to check valid keys.", call. = FALSE)
  }

  message("Fetching metadata for section: '", section, "'...")
  return(meta)
}
