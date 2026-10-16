
#  ------------------------------------------------------------------------
#
# Title : Expectation Test Helpers
#    By : Jimmy Briggs
#  Date : 2026-10-16
#
#  ------------------------------------------------------------------------

expect_entrata_request <- function(req) {
  testthat::expect_s3_class(req, "entrata_request")
  testthat::expect_true(rlang::inherits_all(req, c("entrata_request", "httr2_request")))
  invisible(req)
}

expect_entrata_response <- function(resp) {
  testthat::expect_s3_class(resp, "entrata_response")
  testthat::expect_true(rlang::inherits_all(resp, c("entrata_response", "httr2_response")))
  resp_req <- resp$request
  expect_entrata_request(resp_req)
  invisible(resp)
}

expect_entrata_response_200 <- function(resp) {
  expect_entrata_response(resp)
  testthat::expect_no_error(httr2::resp_status_check(resp))
  status <- httr2::resp_status(resp)
  testthat::expect_equal(status, 200L)
  invisible(resp)
}

# httr2 ----------------------------------------------------------------------------------------------------

expect_httr2_request <- function(req) {
  testthat::expect_s3_class(req, "httr2_request")
}

expect_httr2_response <- function(resp) {
  testthat::expect_s3_class(resp, "httr2_response")
}

expect_httr2_headers <- function(headers) {
  testthat::expect_s3_class(headers, "httr2_headers")
}
