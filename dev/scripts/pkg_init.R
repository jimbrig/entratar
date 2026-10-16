
#  ------------------------------------------------------------------------
#
# Title : Package Initialization
#    By : Jimmy Briggs
#  Date : 2026-10-05
#
#  ------------------------------------------------------------------------

usethis::create_package("entratar")
usethis::use_directory("dev", ignore = TRUE)
usethis::use_git()
usethis::use_namespace()
c(
  ".editorconfig",
  ".gitattributes",
  ".Rprofile",
  ".Renviron"
) |>
  purrr::walk(fs::file_create) |>
  purrr::walk(usethis::use_build_ignore)
usethis::use_git_ignore(c(".Renviron", ".env", ".envrc"))

desc::desc_set(
  "Title" = "API Client for the Entrata Property Management System (PMS) ",
  "Description" = "Comprehensive API client library package to interface and work with services provided by Real Estate API (api.realestateapi.com)."
)


usethis::use_readme_md()
usethis::use_package_doc()

usethis::use_air()
usethis::use_data_raw("internal")
usethis::use_data_raw("exported")

usethis::use_namespace()
usethis::use_readme_md()
usethis::use_package_doc()

usethis::use_git()
usethis::use_github()
usethis::use_github_links()



attachment::att_amend_desc(
  use.config = TRUE,
  path.c = "dev/attachment.config.yml"
)
