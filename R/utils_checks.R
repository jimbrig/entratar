
#  ------------------------------------------------------------------------
#
# Title : Check Utilities
#    By : Jimmy Briggs
#  Date : 2026-10-16
#
#  ------------------------------------------------------------------------

# conditions --------------------------------------------------------------

#' Check Conditions
#'
#' @family checks
#' @family utils
#' @family conditions
#'
#' @description
#' These functions are specialized versions of the `entratar` condition functions that are intended for
#' use in the package's internal checking functions. They create conditions with
#' specific classes that can be used to identify and handle errors, warnings, and messages.
#'
#' @section Functions:
#' - `entrata_abort_check()`: creates an `entrata_error` condition for checks.
#' - `entrata_warn_check()`: creates an `entrata_warning` condition for checks.
#' - `entrata_inform_check()`: creates an `entrata_message` condition for checks.
#'
#' @section Aliases:
#' - `check_abort()`: alias for `entrata_abort_check()`
#' - `check_warn()`: alias for `entrata_warn_check()`
#' - `check_inform()`: alias for `entrata_inform_check()`
#'
#' @inherit entrata_abort
#'
#' @export
entrata_abort_check <- function(msg, ..., parent = NULL, call = rlang::caller_env(), .envir = parent.frame()) {
  entrata_abort(msg = msg, cls = "entrata_check_error", ..., call = call, .envir = .envir)
}

#' @rdname entrata_abort_check
#' @export
entrata_warn_check <- function(msg, ..., call = rlang::caller_env(), .envir = parent.frame()) {
  entrata_warn(msg = msg, cls = "entrata_check_warning", ..., call = call, .envir = .envir)
}

#' @rdname entrata_abort_check
#' @export
entrata_inform_check <- function(msg, ..., call = rlang::caller_env(), .envir = parent.frame()) {
  entrata_inform(msg = msg, cls = "entrata_check_message", ..., .envir = .envir)
}

#' Convenience Alias for `entrata_abort_check()`
#' @rdname entrata_abort_check
#' @export
check_abort <- entrata_abort_check

#' Convenience Alias for `entrata_abort_warn()`
#' @rdname entrata_abort_check
#' @export
check_warn <- entrata_warn_check

#' Convenience Alias for `entrata_abort_inform()`
#' @rdname entrata_abort_check
#' @export
check_inform <- entrata_inform_check

# inherits ----------------------------------------------------------------

#' Class Inheritance Checks
#'
#' @description
#' These functions perform checks that assert the underlying class of objects passed to them.
#'
#' - `check_inherits()`: checks that object `x` is of class `class` using [base::inherits()]
#' - `check_inherits2()`: checks that object `x` is of class `class` using [base::.class2()]
#' - `check_inherits_any()`: checks that object `x` is at least one of the provided `classes` via [rlang::inherits_any()]
#' - `check_inherits_all()`: checks that object `x` is all of the provided `classes` via [rlang::inherits_all()]
#'
#' If validation fails for any of these functions, an error is thrown via `check_abort()` displaying a friendly
#' error message.
#'
#' @param x The object to check.
#' @param class,classes The name of the class or classes to use during checking.
#' @inheritParams rlang::args_error_context
#'
#' @returns
#' If checks pass, invisibly returns the provided `x` object. If checks fail, a condition error is thrown.
#'
#' @export
check_inherits <- function(x, class, arg = rlang::caller_arg(x), call = rlang::caller_env()) {
  if (!inherits(x, class)) {
    check_abort("{.arg {arg}} must inherit from class {.cls {class}}, not {.obj_type_friendly {x}}.", call = call)
  }
  invisible(x)
}

#' @rdname check_inherits
#' @export
check_inherits2 <- function(x, class, arg = rlang::caller_arg(x), call = rlang::caller_env()) {
  if (!(class %in% .class2(x))) {
    check_abort("{.arg {arg}} must inherit from class {.cls {class}}, not {.cls {.class2(x)}}", call = call)
  }
  invisible(x)
}

#' @rdname check_inherits
#' @export
#' @importFrom rlang inherits_any
check_inherits_any <- function(x, classes, arg = rlang::caller_arg(x), call = rlang::caller_env()) {
  if (!rlang::inherits_any(x, classes)) {
    check_abort(
      "{.arg {arg}} must inherit from one of the classes: {.cls {classes}}, not {.obj_type_friendly {x}}.",
      call = call
    )
  }
  invisible(x)
}

#' @rdname check_inherits
#' @export
#' @importFrom rlang inherits_all
check_inherits_all <- function(x, classes, arg = rlang::caller_arg(x), call = rlang::caller_env()) {
  if (!rlang::inherits_all(x, classes)) {
    check_abort(
      "{.arg {arg}} must inherit from all of the classes: {.cls {classes}}, not {.obj_type_friendly {x}}.",
      call = call
    )
  }
  invisible(x)
}

# typeof ------------------------------------------------------------------

check_typeof <- function(x, type, arg = rlang::caller_arg(x), call = rlang::caller_env()) {
  if (!identical(typeof(x), type)) {
    check_abort("{.arg {arg}} must be of type {.cls {type}}, not {.obj_type_friendly {x}}.", call = call)
  }
  invisible(x)
}


# empty -----------------------------------------------------------------------------------------------------------

#' Check Not Empty
#'
#' @description
#' Checks the provided `x` is not "empty" via [rlang::is_empty()].
#'
#' @inheritParams check_inherits
#'
#' @returns
#' If checks pass, invisibly returns the provided `x` object. If checks fail, a condition error is thrown.
#'
#' @export
#'
#' @importFrom rlang is_empty
check_not_empty <- function(x, arg = rlang::caller_arg(x), call = rlang::caller_env()) {
  if (rlang::is_empty(x)) {
    check_abort("{.arg {arg}} must not be empty.", call = call)
  }
  invisible(x)
}

# scalars -----------------------------------------------------------------

#' Check String (Scalar)
#'
#' @description
#' Checks the provided `x` is a scalar string via [rlang::check_string()].
#'
#' @inheritParams rlang::check_string
#'
#' @returns
#' If `x` is not a scalar string, an error is thrown. Otherwise, `x` is invisibly
#' returned.
#'
#' @export
#'
#' @importFrom rlang try_fetch check_string
check_string <- function(x, allow_empty = FALSE, allow_na = FALSE, allow_null = FALSE, arg = rlang::caller_arg(x), call = rlang::caller_env()) {
  rlang::try_fetch({
    rlang::check_string(x, allow_empty = allow_empty, allow_na = allow_na, allow_null = allow_null, arg = arg, call = call)
  }, error = function(err) {
    check_abort(msg = rlang::cnd_message(err), parent = err, arg = arg, call = call)
  })
  invisible(x)
}

# vectors -----------------------------------------------------------------



# structures --------------------------------------------------------------



# names -------------------------------------------------------------------

#' @importFrom rlang is_named
check_named <- function(x, arg = rlang::caller_arg(x), call = rlang::caller_env()) {
  if (!rlang::is_named(x)) {
    check_abort("{.arg {arg}} must be a named vector or list.", call = call)
  }
  invisible(x)
}

#' @importFrom rlang is_named2
check_named2 <- function(x, arg = rlang::caller_arg(x), call = rlang::caller_env()) {
  if (!rlang::is_named2(x)) {
    check_abort("{.arg {arg}} must be a named vector or list.", call = call)
  }
  invisible(x)
}

check_names <- function(x, required, arg = rlang::caller_arg(x), call = rlang::caller_env()) {
  check_named(x, arg = arg, call = call)
  missing_names <- setdiff(required, names(x))
  if (length(missing_names) > 0) {
    check_abort("{.arg {arg}} is missing required names: {.field {missing_names}}.", call = call)
  }
  invisible(x)
}

# dates/times -------------------------------------------------------------

check_date <- function(x, arg = rlang::caller_arg(x), call = rlang::caller_env()) {
  check_inherits_any(x, classes = c("Date", "POSIXct"), arg = arg, call = call)
}

check_time <- function(x, arg = rlang::caller_arg(x), call = rlang::caller_env()) {
  check_inherits(x, "POSIXt", arg = arg, call = call)
  check_inherits_any(x, classes = c("POSIXct", "POSIXlt"), arg = arg, call = call)
}

# paths -------------------------------------------------------------------

check_path <- function(x, arg = rlang::caller_arg(x), call = rlang::caller_env()) {
  check_string(x, allow_empty = FALSE, arg = arg, call = call)
  if (!file.exists(x)) {
    check_abort("{.arg {arg}} must be a valid file or folder path that exists: {.file {x}} does not exist.", call = call)
  }
  invisible(x)
}

check_folder <- function(x, arg = rlang::caller_arg(x), call = rlang::caller_env()) {
  check_string(x, allow_empty = FALSE, arg = arg, call = call)
  if (!dir.exists(x)) {
    check_abort("{.arg {arg}} must be a valid folder path: {.path {x}} does not exist.", call = call)
  }
  invisible(x)
}

#' @importFrom tools file_ext
check_file <- function(x, ext = NULL, arg = rlang::caller_arg(x), call = rlang::caller_env()) {
  check_path(x, arg = arg, call = call)
  if (is.null(ext)) return(invisible(x))
  ext <- tolower(ext)
  ext <- gsub("*", "", ext, fixed = TRUE)
  ext <- gsub(".", "", ext, fixed = TRUE)
  if (length(ext) > 1L) {
    if (!any(tools::file_ext(x) %in% ext)) {
      check_abort("{.arg {arg}} must have one of the following extensions: {.field {ext}}.", call = call)
    }
  } else {
    if (tools::file_ext(x) != ext) {
      check_abort("{.arg {arg}} must have the extension {.field {ext}}.", call = call)
    }
  }
  invisible(x)
}

# regex -------------------------------------------------------------------

check_regex <- function(x, pattern, arg = rlang::caller_arg(x), call = rlang::caller_env()) {
  check_string(x, call = call)
  if (!grepl(pattern, x)) {
    check_abort("{.arg {arg}} must match the regular expression pattern: {.field {pattern}}.", call = call)
  }
  invisible(x)
}


# urls --------------------------------------------------------------------


check_url <- function(x, arg = rlang::caller_arg(x), call = rlang::caller_env()) {
  check_string(x, allow_empty = FALSE, arg = arg, call = call)
  check_regex(x, pattern = "^(http|https)://", arg = arg, call = call)
  invisible(x)
}

check_ipv4 <- function(x, arg = rlang::caller_arg(x), call = rlang::caller_env()) {
  check_string(x, allow_empty = FALSE, arg = arg, call = call)
  pattern <- "^((25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$"
  check_regex(x, pattern = pattern, arg = arg, call = call)
  invisible(x)
}


# http --------------------------------------------------------------------

#' @importFrom rlang is_integerish
check_http_status_code <- function(x, arg = rlang::caller_arg(x), call = rlang::caller_env()) {
  if (!rlang::is_integerish(x, n = 1, finite = TRUE) || x < 100 || x > 599) {
    check_abort("{.arg {arg}} must be a single HTTP status code between 100 and 599, not {.val {x}}.", call = call)
  }
  invisible(x)
}

# entrata -----------------------------------------------------------------

check_entrata_request <- function(x, arg = rlang::caller_arg(x), call = rlang::caller_env()) {
  check_inherits(x, class = "entrata_request", arg = arg, call = call)
}

check_entrata_response <- function(x, arg = rlang::caller_arg(x), call = rlang::caller_env()) {
  check_inherits(x, class = "entrata_response", arg = arg, call = call)
}

# httr2 -------------------------------------------------------------------

check_httr2_url <- function(x, arg = rlang::caller_arg(x), call = rlang::caller_env()) {
  check_inherits(x, class = "httr2_url", arg = arg, call = call)
}

check_httr2_request <- function(x, arg = rlang::caller_arg(x), call = rlang::caller_env()) {
  check_inherits(x, class = "httr2_request", arg = arg, call = call)
}

check_httr2_requests <- function(x, arg = rlang::caller_arg(x), call = rlang::caller_env()) {
  check_inherits(x, class = "httr2_requests", arg = arg, call = call)
}

check_httr2_response <- function(x, arg = rlang::caller_arg(x), call = rlang::caller_env()) {
  check_inherits(x, class = "httr2_response", arg = arg, call = call)
}

check_httr2_responses <- function(x, arg = rlang::caller_arg(x), call = rlang::caller_env()) {
  check_inherits(x, class = "httr2_responses", arg = arg, call = call)
}

check_httr2_headers <- function(x, arg = rlang::caller_arg(x), call = rlang::caller_env()) {
  check_inherits(x, class = "httr2_headers", arg = arg, call = call)
}


# json --------------------------------------------------------------------

check_json_str <- function(x, arg = rlang::caller_arg(x), call = rlang::caller_env()) {
  if (!is_valid_json_str(x)) {
    check_abort("{.arg {arg}} must be a valid JSON string.", arg = arg, call = call)
  }
  invisible(x)
}

check_json_file <- function(x, arg = rlang::caller_arg(x), call = rlang::caller_env()) {
  if (!is_valid_json_file(x)) {
    check_abort("{.arg {arg}} must be a valid path to a JSON file.", arg = arg, call = call)
  }
  invisible(x)
}

# internal ----------------------------------------------------------------

#' An empty time object for error messages
#' @keywords internal
#' @noRd
.time_type_obj <- function() {
  structure(double(), class = "time")
}
