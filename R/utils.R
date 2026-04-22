map_url_irpf <- function(section) {
  url <- irpf_urls_dictionary[[section]]

  if (is.null(url) || url == "") {
    mapped_sections <- names(irpf_urls_dictionary)[sapply(irpf_urls_dictionary, function(x) x != "")]
    stop("Section not found or URL not mapped yet. Available: ",
         paste(mapped_sections, collapse = ", "), call. = FALSE)
  }

  return(url)
}
