
#  ------------------------------------------------------------------------
#
# Title : Entrata Configuration
#    By : Jimmy Briggs
#  Date : 2026-10-15
#
#  ------------------------------------------------------------------------

entrata_config <- function(
  api_key = Sys.getenv("ENTRATA_API_KEY"),
  org = Sys.getenv("ENTRATA_API_ORG", "rsync"),
  gateway_url = "https://apis.entrata.com",
  api_version = "v1"
) {

}

new_entrata_config <- function(api_key, org, gateway_url = "https://apis.entrata.com", api_version = "v1") {
  structure(
    list(
      api_key = api_key,
      org = org,
      gateway_url = gateway_url,
      api_version = api_version,
      base_url = as.character(file.path(gateway_url, "ext", "orgs", org, api_version))
    ),
    class = c("entrata_config")
  )
}
