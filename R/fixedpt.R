


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#' New fixed point
#'
#' @param x vector of doubles
#' @param decimals number of decimal places required in representation
#'
#' @import vctrs
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
new_fixedpt <- function(x = double(), decimals = 3) {
  vctrs::vec_assert(x, double())

  decimals <- as.integer(decimals)
  stopifnot(decimals >= 0)

  sf <- 10^decimals
  x <- as.integer(round(x * sf))

  vctrs::new_vctr(x, sf = sf, dp = decimals, class = "typ_fixedpt")
}


sf <- function(x) attr(x, 'sf', exact = TRUE)
dp <- function(x) attr(x, 'dp', exact = TRUE)


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#' Create a vector of \code{fixedpt} values from numeric values
#'
#' @param x vector of doubles
#' @param decimals number of decimal places required in representation
#'
#' @return fixedpt vector
#' @export
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
fixedpt <- function(x = double(), decimals = 3) {
  x <- vctrs::vec_cast(x, double())
  new_fixedpt(x, decimals = decimals)
}


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#' Test if object is \code{fixedpt}
#'
#' @param x object
#'
#' @return logical
#' @export
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
is_fixedpt <- function(x) {
  inherits(x, "typ_fixedpt")
}

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#' Convert to fixedpt
#'
#' @param x vector
#'
#' @export
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
as_fixedpt <- function(x) {
  vctrs::vec_cast(x, new_fixedpt())
}

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#' Format a \code{fixedpt} value
#'
#' @param x object
#' @param ... ignored
#'
#' @export
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
format.typ_fixedpt <- function(x, ...) {
  formatC(vctrs::vec_data(x)/sf(x), format = 'f', digits = dp(x))
}


# nocov start
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#' Abbreviation to use in some outputs e.g. \code{tibble}
#'
#' @param x object
#' @param ... ignored
#'
#' @export
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
vec_ptype_abbr.typ_fixedpt <- function(x, ...) {
  "fixpt"
}

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#' Coercion between \code{fixedpt} and \code{double}
#'
#' @param x,y objects
#' @param ... ignored
#'
#' @export
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
vec_ptype2.typ_fixedpt.typ_fixedpt <- function(x, y, ...) new_fixedpt()

#' @rdname vec_ptype2.typ_fixedpt.typ_fixedpt
#' @export
vec_ptype2.typ_fixedpt.double  <- function(x, y, ...) double()

#' @rdname vec_ptype2.typ_fixedpt.typ_fixedpt
#' @export
vec_ptype2.double.typ_fixedpt  <- function(x, y, ...) double()


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#' Cast between \code{fixedpt} and \code{double}
#'
#' @param x object
#' @param to conversion target type
#' @param ... ignored
#'
#' @export
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
vec_cast.typ_fixedpt.typ_fixedpt <- function(x, to, ...) x

#' @rdname vec_cast.typ_fixedpt.typ_fixedpt
#' @export
vec_cast.typ_fixedpt.double <- function(x, to, ...) fixedpt(x)

#' @rdname vec_cast.typ_fixedpt.typ_fixedpt
#' @export
vec_cast.double.typ_fixedpt <- function(x, to, ...) vctrs::vec_data(x)/sf(x)

#' @rdname vec_cast.typ_fixedpt.typ_fixedpt
#' @export
vec_cast.character.typ_fixedpt <- function(x, to, ...) {
  formatC(vctrs::vec_data(x)/sf(x), format = 'f', digits = dp(x))
}

# nocov end


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#' Math function calls on \code{fixedpt}
#'
#' @param .fn function name as string
#' @param .x fixedpt object
#' @param ... other arguments to \code{.fn}
#'
#' @export
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
vec_math.typ_fixedpt <- function(.fn, .x, ...) {
  .fn <- getExportedValue("base", .fn)
  new_fixedpt(
    .fn(vec_cast(.x, double()), ...),
    decimals = dp(.x)
  )
}


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#' Arithmetic ops on \code{fixedpt}
#'
#' Note: results will have as many decomals as the maximum of the two arguments,
#' so there's always the posibility of overflow.
#'
#' @param op  function
#' @param x,y lhs, rhs
#' @param ... ignored
#'
#' @export
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
vec_arith.typ_fixedpt <- function(op, x, y, ...) {
  args <- vec_recycle_common(x, y)
  op_fn <- getExportedValue("base", op)
  new_fixedpt(
    op_fn(
      vctrs::vec_cast(args[[1L]], double()),
      vctrs::vec_cast(args[[2L]], double())
    ),
    decimals = max(dp(x), dp(y))
  )
}



