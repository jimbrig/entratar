
#  ------------------------------------------------------------------------
#
# Title : Entrata Conditions
#    By : Jimmy Briggs
#  Date : 2026-10-15
#
#  ------------------------------------------------------------------------

# topic -------------------------------------------------------------------

#' `entratar` Custom Conditions
#'
#' @name entratar-conditions
#' @aliases conditions
#' @family conditions
#' @family package
#'
#' @description
#' Functions for creating and handling custom Entrata-specific conditions, including errors, warnings, and messages.
#'
#' - `entrata_abort()`: creates a condition representing an error and when thrown, aborts execution.
#' - `entrata_warn()`: creates a condition representing a warning condition
#' - `entrata_inform()`: creates a condition representing a message condition
#'
#' These functions wrap [cli::cli_abort()], [cli::cli_warn()], and [cli::cli_inform()] respectively,
#' adding `entratar`-specific context and class names (`entrata_*`) to the condition objects for
#' downstream handling and identification.
#'
#' @details
#' The condition class hierarchy is structured like so:
#'
#' ```plaintext
#' <entrata_condition>
#'   ├── <entrata_error>
#'   │   ├── <entrata_{custom}_error>
#'   ├── <entrata_warning>
#'   │   ├── <entrata_{custom}_warning>
#'   ├── <entrata_message>
#'   └────── <entrata_{custom}_message>
#' ```
#'
#' where `<entrata_condition>` is the base class for all `entratar` conditions
#' and sits on top of the existing `rlang` and base R condition classes.
#'
#' For example, an `entrata` error thrown without any additional custom class added
#' to it using `entrata_abort()` will have the following classes:
#'
#' ```R
#' [1] "entrata_error" "entrata_condition" "rlang_error" "error" "condition"
#' ```
#'
#' This allows for filtering and handling of Entrata-specific conditions while
#' still being compatible with the broader R condition system.
#'
#' @param msg Character string or vector containing the message to be displayed. This gets
#'   passed to [cli::cli_bullets()] allowing for `cli`'s custom formatting,
#'   `glue` interpolation, inline markup syntax, and other features.
#' @param cls Optional character vector of additional classes to assign to the condition.
#' @inheritParams cli::cli_abort
#'
#' @returns
#' These functions do not return values, but are used for their side effects, namely
#' creating and signaling conditions. The `entrata_abort()` function will stop
#' execution, while `entrata_warn()` & `entrata_inform()` will allow execution
#' to proceed.
#'
#' @examples
#' \dontrun{
#' entrata_abort("This is a entratar error.")
#'
#' # catch a condition and check its classes
#' err <- rlang::catch_cnd(entrata_abort("Error Message"))
#' class(err)
#'
#' # catch a warning and check its classes
#' wrn <- rlang::catch_cnd(entrata_warn("Warning Message"))
#' class(wrn)
#'
#' # catch a message and check its classes
#' msg <- rlang::catch_cnd(entrata_inform("Message"))
#' class(msg)
#' }
NULL

# abort -------------------------------------------------------------------

#' @rdname entratar-conditions
#' @export
#' @importFrom cli cli_abort
#' @importFrom rlang caller_env
entrata_abort <- function(msg = NULL, cls = NULL, ..., parent = NULL, call = rlang::caller_env(), .envir = parent.frame()) {
  classes <- c(cls, "entrata_error", "entrata_condition")
  cli::cli_abort(message = msg, class = classes, parent = parent, call = call, .envir = .envir, ...)
}

# warn --------------------------------------------------------------------

#' @rdname entratar-conditions
#' @export
#' @importFrom cli cli_warn
entrata_warn <- function(msg = NULL, cls = NULL, ..., .envir = parent.frame()) {
  classes <- c(cls, "entrata_warning", "entrata_condition")
  cli::cli_warn(message = msg, class = classes, .envir = .envir, ...)
}


# inform ------------------------------------------------------------------

#' @rdname entratar-conditions
#' @export
#' @importFrom cli cli_inform
entrata_inform <- function(msg = NULL, cls = NULL, ..., .envir = parent.frame()) {
  classes <- c(cls, "entrata_message", "entrata_condition")
  cli::cli_inform(message = msg, class = classes, .envir = .envir, ...)
}

# checks ------------------------------------------------------------------



# testing helpers ---------------------------------------------------------


# internal ----------------------------------------------------------------


