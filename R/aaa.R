
#  ------------------------------------------------------------------------
#
# Title : aaa.R - Package Shared Resources & roxygen2
#    By : Jimmy Briggs
#  Date : 2026-10-15
#
#  ------------------------------------------------------------------------

# rlang -------------------------------------------------------------------

#' @inheritParams rlang::args_error_context
#' @inheritParams rlang::args_dots_empty
#' @inheritParams rlang::args_data_masking
NULL

# parameters --------------------------------------------------------------

#' Shared Parameters
#'
#' @name .shared-params
#' @keywords internal
#' @noRd
#'
#' @description
#' Common, shared parameter definitions that can be re-used and inherited by other
#' functions in the package. They are defined here to make it easier to update
#' them in one place and maintain consistency.
#'
#' To use these parameters in a function, simply include the following
#' in the function's documentation:
#'
#' ```
#' #' @inheritParams .shared-params
#' ```
#'
#' @param req An [httr2::request()] object.
#' @param resp An [httr2::response()] object.
NULL

# returns - response ------------------------------------------------------

#' Shared `entrata_response` Return
#'
#' @name .shared-return-response
#' @keywords internal
#' @noRd
#'
#' @description
#' Use this shared return for functions returning an `entrata_response`:
#'
#' ```
#' #' @inherit .shared-return-response returns
#' ```
#'
#' @returns
#' An object of class `entrata_response`.
NULL

# returns - request -------------------------------------------------------

#' Shared `entrata_request` Return
#'
#' @name .shared-return-request
#' @keywords internal
#' @noRd
#'
#' @description
#' Use this shared return for functions returning an `entrata_request`:
#'
#' ```
#' #' @inherit .shared-return-request returns
#' ```
#'
#' @returns
#' An object of class `entrata_request`.
NULL



