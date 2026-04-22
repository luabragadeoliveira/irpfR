test_that("get_sections returns a valid tibble", {
  res <- get_sections()

  expect_s3_class(res, "data.frame")

  expect_named(res, c("secao", "descricao"))

  expect_true("bens_e_direitos" %in% res$secao)
})
