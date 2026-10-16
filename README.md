
# entratar <a href="http://docs.jimbrig.com/entratar/"><img src="man/figures/logo.png" align="right" height="139" alt="entratar website" /></a>

<!-- badges: start -->
[![Automate Changelog](https://github.com/jimbrig/entratar/actions/workflows/changelog.yml/badge.svg)](https://github.com/jimbrig/entratar/actions/workflows/changelog.yml)
[![pkgdown](https://github.com/jimbrig/entratar/actions/workflows/pkgdown.yml/badge.svg)](https://github.com/jimbrig/entratar/actions/workflows/pkgdown.yml)
[![R Universe Version](https://jimbrig.r-universe.dev/entratar/badges/version)](https://jimbrig.r-universe.dev/entratar)
<!-- badges: end -->

## Overview

> [!NOTE]
> *`entratar` is still in early stages of development.*

`entratar` provides a robust, production grade API client library for [Entrata][entrata-home],
a leading property management system provider vendor for real estate property management companies.

See the [package documentation][pkg-docs] for the full library reference and the
official [Entrata Developer Portal][entrata-developer] for more details.

## Installation

You can install the development version of `entratar` from [GitHub][pkg-repo] with:

```r
# using pak & github
pak::pak("jimbrig/entratar")
```

or via [R Universe][pkg-runiverse] with:

```r
install.packages("entratar", repos = c("https://jimbrig.r-universe.dev", getOption("repos")))
```

## Usage

```r
# can set envvars before loading the library to auto-detect and configure them
Sys.setenv("ENTRATA_API_KEY" = "...")
Sys.setenv("ENTRATA_API_ORG" = "...")

library(entratar)

# or set the interactively:
entrata_config(api_key = "...", org = "...")

# check status via /status getStatus
entrata_status()
```

## Endpoints

- `/status`
- `/appinfo`
- `/applications`
- `/properties`
- `/propertyunits`
- `/leases`
- `/leasingunits`
- `/financial`
- `/pricing`
- `/reports` & `/queue`

## Contributing

Corrections, counterexamples, and public examples that strengthen or challenge the design guidance are especially welcome.

## License

See [LICENSE](./LICENSE)


<!-- links: start -->
[pkg-repo]: https://github.com/jimbrig/entratar
[pkg-docs]: https://docs.jimbrig.com/entratar
[pkg-vignette]: https://docs.jimbrig.com/entratar/articles/entratar.html
[pkg-runiverse]: https://jimbrig.r-universe.dev/entratar
[entrata-home]: https://entrata.com/
[entrata-developer]: https://developer.entrata.com/
[httr2]: https://httr2.r-lib.org/
<!-- links: end -->
