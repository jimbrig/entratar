# entratar

## Overview

> \[!NOTE\] *`entratar` is still in early stages of development.*

`entratar` provides a robust, production grade API client library for
[Entrata](https://entrata.com/), a leading property management system
provider vendor for real estate property management companies.

See the [package documentation](https://docs.jimbrig.com/entratar) for
the full library reference and the official [Entrata Developer
Portal](https://developer.entrata.com/) for more details.

## Installation

You can install the development version of `entratar` from
[GitHub](https://github.com/jimbrig/entratar) with:

``` r

# using pak & github
pak::pak("jimbrig/entratar")
```

or via [R Universe](https://jimbrig.r-universe.dev/entratar) with:

``` r

install.packages("entratar", repos = c("https://jimbrig.r-universe.dev", getOption("repos")))
```

## Usage

``` r

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

Corrections, counterexamples, and public examples that strengthen or
challenge the design guidance are especially welcome.

## License

See [LICENSE](http://docs.jimbrig.com/entratar/LICENSE)
