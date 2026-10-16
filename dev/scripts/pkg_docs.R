
#  ------------------------------------------------------------------------
#
# Title : Package Documentation
#    By : Jimmy Briggs
#  Date : 2026-10-16
#
#  ------------------------------------------------------------------------

# roxygen2 --------------------------------------------------------------------------------------------------------

usethis::use_package_doc()

desc::desc_set("Config/roxygen2/markdown", "TRUE")
desc::desc_set("Config/roxygen2/version", utils::packageVersion("roxygen2"))

fs::dir_create("man/roxygen")
fs::file_create("man/roxygen/meta.R")

attachment::att_amend_desc(use.config = TRUE, path.c = "dev/attachment.config.yml")

# readme ----------------------------------------------------------------------------------------------------------

usethis::use_readme_md()

# changelog -------------------------------------------------------------------------------------------------------

file.create("CHANGELOG.md")
usethis::use_build_ignore("CHANGELOG.md")
usethis::use_github_action(url = "https://github.com/noclocks/.github/blob/main/.github/workflows/changelog.yml")

# vignettes -------------------------------------------------------------------------------------------------------

usethis::use_vignette("entratar", title = "Getting Started")


# images ----------------------------------------------------------------------------------------------------------

fs::dir_create("man/figures")
fs::dir_create("man/fragments")
fs::dir_create("man/roxygen")

# can get official logos via branfetch logo api:

readRenviron(".Renviron")
brandfetch_client_id <- Sys.getenv("BRANDFETCH_CLIENT_ID")
icon_red_cdn_url <- paste0("https://cdn.brandfetch.io/domain/entrata.com/w/800/h/800?c=", brandfetch_client_id)
logo_black_transparent_cdn_url <- paste0("https://cdn.brandfetch.io/domain/entrata.com/w/820/h/155/logo?c=", brandfetch_client_id)

# icon_red_resp <- httr2::request(icon_red_cdn_url) |>
#   httr2::req_method("HEAD") |>
#   httr2::req_options(followlocation = TRUE, maxredirs = 10L) |>
#   httr2::req_perform()
# httr2::resp_headers(icon_red_resp)

download.file(icon_red_cdn_url, destfile = file.path("man/figures/entrata.icon.red.800x800.webp"))
download.file(logo_black_transparent_cdn_url, destfile = file.path("man/figures/entrata.logo.transparent.820x155.webp"))

# brand -------------------------------------------------------------------

brandfetch_api_key <- Sys.getenv("BRANDFETCH_API_KEY")
entrata_brand_request <- httr2::request("https://api.brandfetch.io/v2/brands") |>
  httr2::req_url_path_append("entrata.com") |>
  httr2::req_auth_bearer_token(token = brandfetch_api_key)
entrata_brand_response <- httr2::req_perform(entrata_brand_request)
entrata_brand_json <- httr2::resp_body_json(entrata_brand_response)
entrata_brand_json |> jsonlite::write_json(file.path("dev/entrata.brandfetch.response.json"), pretty = TRUE, auto_unbox = TRUE)

# banner from brand:
entrata_banner_url <- entrata_brand_json$images[[1]]$formats[[1]]$src
download.file(entrata_banner_url, destfile = "man/figures/entrata.banner.jpeg")

# pkgdown ---------------------------------------------------------------------------------------------------------

usethis::use_pkgdown_github_pages()
file.rename(".github/workflows/pkgdown.yaml", ".github/workflows/pkgdown.yml")

usethis::use_directory("pkgdown", ignore = TRUE)
fs::file_move("_pkgdown.yml", "pkgdown/_pkgdown.yml")
pkgdown::build_favicons()

# badges ----------------------------------------------------------------------------------------------------------

usethis::use_badge(badge_name = "Automate Changelog", href = "https://github.com/jimbrig/entratar/actions/workflows/changelog.yml", src = "https://github.com/jimbrig/entratar/actions/workflows/changelog.yml/badge.svg")
usethis::use_badge("pkgdown", "https://github.com/jimbrig/entratar/actions/workflows/pkgdown.yml", "https://github.com/jimbrig/entratar/actions/workflows/pkgdown.yml/badge.svg")
usethis::use_r_universe_badge()
