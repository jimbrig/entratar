# Check Conditions

These functions are specialized versions of the `entratar` condition
functions that are intended for use in the package's internal checking
functions. They create conditions with specific classes that can be used
to identify and handle errors, warnings, and messages.

## Usage

``` r
entrata_abort_check(
  msg,
  ...,
  parent = NULL,
  call = rlang::caller_env(),
  .envir = parent.frame()
)

entrata_warn_check(
  msg,
  ...,
  call = rlang::caller_env(),
  .envir = parent.frame()
)

entrata_inform_check(
  msg,
  ...,
  call = rlang::caller_env(),
  .envir = parent.frame()
)

check_abort(
  msg,
  ...,
  parent = NULL,
  call = rlang::caller_env(),
  .envir = parent.frame()
)

check_warn(msg, ..., call = rlang::caller_env(), .envir = parent.frame())

check_inform(msg, ..., call = rlang::caller_env(), .envir = parent.frame())
```

## Arguments

- msg:

  Character string or vector containing the message to be displayed.
  This gets passed to
  [`cli::cli_bullets()`](https://cli.r-lib.org/reference/cli_bullets.html)
  allowing for `cli`'s custom formatting, `glue` interpolation, inline
  markup syntax, and other features.

- ...:

  Passed to
  [`rlang::abort()`](https://rlang.r-lib.org/reference/abort.html),
  [`rlang::warn()`](https://rlang.r-lib.org/reference/abort.html) or
  [`rlang::inform()`](https://rlang.r-lib.org/reference/abort.html).

- call:

  The execution environment of a currently running function, e.g.
  `call = caller_env()`. The corresponding function call is retrieved
  and mentioned in error messages as the source of the error.

  You only need to supply `call` when throwing a condition from a helper
  function which wouldn't be relevant to mention in the message.

  Can also be `NULL` or a [defused function
  call](https://rlang.r-lib.org/reference/topic-defuse.html) to
  respectively not display any call or hard-code a code to display.

  For more information about error calls, see [Including function calls
  in error
  messages](https://rlang.r-lib.org/reference/topic-error-call.html).

- .envir:

  Environment to evaluate the glue expressions in.

## Value

These functions do not return values, but are used for their side
effects, namely creating and signaling conditions. The
[`entrata_abort()`](http://docs.jimbrig.com/entratar/reference/entratar-conditions.md)
function will stop execution, while
[`entrata_warn()`](http://docs.jimbrig.com/entratar/reference/entratar-conditions.md)
&
[`entrata_inform()`](http://docs.jimbrig.com/entratar/reference/entratar-conditions.md)
will allow execution to proceed.

## Details

The condition class hierarchy is structured like so:

where `<entrata_condition>` is the base class for all `entratar`
conditions and sits on top of the existing `rlang` and base R condition
classes.

For example, an `entrata` error thrown without any additional custom
class added to it using
[`entrata_abort()`](http://docs.jimbrig.com/entratar/reference/entratar-conditions.md)
will have the following classes:

    [1] "entrata_error" "entrata_condition" "rlang_error" "error" "condition"

This allows for filtering and handling of Entrata-specific conditions
while still being compatible with the broader R condition system.

## Functions

- `entrata_abort_check()`: creates an `entrata_error` condition for
  checks.

- `entrata_warn_check()`: creates an `entrata_warning` condition for
  checks.

- `entrata_inform_check()`: creates an `entrata_message` condition for
  checks.

## Aliases

- `check_abort()`: alias for `entrata_abort_check()`

- `check_warn()`: alias for `entrata_warn_check()`

- `check_inform()`: alias for `entrata_inform_check()`

## See also

Utility Functions:
[`entrata_active_config`](http://docs.jimbrig.com/entratar/reference/entrata_active_config.md)

Conditions:
[`entratar-conditions`](http://docs.jimbrig.com/entratar/reference/entratar-conditions.md)

## Examples

``` r
if (FALSE) { # \dontrun{
entrata_abort("This is a entratar error.")

# catch a condition and check its classes
err <- rlang::catch_cnd(entrata_abort("Error Message"))
class(err)

# catch a warning and check its classes
wrn <- rlang::catch_cnd(entrata_warn("Warning Message"))
class(wrn)

# catch a message and check its classes
msg <- rlang::catch_cnd(entrata_inform("Message"))
class(msg)
} # }
```
