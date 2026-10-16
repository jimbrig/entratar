
#  ------------------------------------------------------------------------
#
# Title : Package Utilities
#    By : Jimmy Briggs
#  Date : 2026-09-06
#
#  ------------------------------------------------------------------------

# meta ------------------------------------------------------------------------------------------------------------

#' @keywords internal
#' @noRd
pkg_name <- function() {
  "entratar"
}

#' @keywords internal
#' @noRd
#' @importFrom utils packageVersion
pkg_version <- local({
  version <- NULL
  function() {
    if (is.null(version)) {
      version <<- as.character(utils::packageVersion(pkg_name()))
    }
    version
  }
})

#' @keywords internal
#' @noRd
pkg_repo <- function(url = FALSE) {
  if (url) {
    return(desc::desc_get_field("repo"))
  }

}

# user agent ------------------------------------------------------------------------------------------------------

#' @keywords internal
#' @noRd
pkg_user_agent <- function() {
  paste0(pkg_name(), "/", pkg_version())
}

# system file -----------------------------------------------------------------------------------------------------

#' @keywords internal
#' @noRd
pkg_sys <- function(...) {
  normalizePath(system.file(..., package = pkg_name()), winslash = "/")
}

# startup message -------------------------------------------------------------------------------------------------

#' @keywords internal
#' @noRd
#' @importFrom crayon bold cyan yellow
pkg_startup_msg <- function() {
  cli::format_message(
    c(

    )
  )

  msg_title <- paste0(crayon::bold(crayon::yellow(pkg_name(), paste0("v", pkg_version()))), "\n")
  msg_banner <- paste0(crayon::cyan(crayon::bold(pkg_banner())), "\n")
  msg_desc <- crayon::bold(crayon::yellow("Entrata PMS API Client Library"))
  msg_reminder <-
  invisible(paste0(msg_banner, msg_title, msg_desc))
}

# banner ----------------------------------------------------------------------------------------------------------

#' @keywords internal
#' @noRd
pkg_banner <- function() {
  .pkg_banner_str
}

#' @keywords internal
#' @noRd
#' @seealso https://manytools.org/hacker-tools/ascii-banner/
.pkg_banner_str <- r"(
    _______   ____________  ___  _________    ____
   / ____/ | / /_  __/ __ \/   |/_  __/   |  / __ \
  / __/ /  |/ / / / / /_/ / /| | / / / /| | / /_/ /
 / /___/ /|  / / / / _, _/ ___ |/ / / ___ |/ _, _/
/_____/_/ |_/ /_/ /_/ |_/_/  |_/_/ /_/  |_/_/ |_|

)"
