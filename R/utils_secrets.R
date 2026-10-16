
#  ------------------------------------------------------------------------
#
# Title : Secrets Utilities
#    By : Jimmy Briggs
#  Date : 2026-10-15
#
#  ------------------------------------------------------------------------

new_secret <- function(value, label = "", kind = "secret") {
  check_string(value)
  structure(
    value,
    label = label,
    kind = kind,
    class = c("secret", "character")
  )
}

#' @export
#' @importFrom rlang caller_env
as_secret <- function(x, label = "", kind = "secret", ..., call = rlang::caller_env()) {
  UseMethod("as_secret", x)
}

#' @export
#' @importFrom rlang caller_env
as_secret.default <- function(x, label = "", kind = "secret", ..., call = rlang::caller_env()) {
  entrata_abort(
    msg = "{.arg x} must be a coercible to a character string secret, not {.cls {class(x)}}",
    cls = "secret_error",
    call = call
  )
}

#' @export
#' @importFrom rlang caller_env
as_secret.NULL <- function(x, label = "", kind = "secret", call = rlang::caller_env()) {
  new_secret(value = NULL, label = label, kind = kind)
}

#' @export
#' @importFrom rlang caller_env
as_secret.secret <- function(x, ...) {
  x
}

#' @export
#' @importFrom rlang caller_env
as_secret.character <- function(x, label = "", kind = "secret", ..., call = rlang::caller_env()) {
  check_string(x, call = call)
  new_secret(value = x, label = label, kind = kind)
}


#' @export
is_secret <- function(x) {
  inherits(x, "secret")
}

#' @export
reveal <- function(x) {

}

secret_label <- function() {

}

secret_kind <- function() {

}

.is_scalar_string <- function(x, allow_empty = FALSE) {
  all(is.character(x), length(x) == 1L, !is.na(x), (allow_empty || nzchar(x)))
}


