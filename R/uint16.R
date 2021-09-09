

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#' constructor
#'
#' @param x integer
#'
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
new_uint16 <- function(x = integer()) {
  vctrs::vec_assert(x, ptype = integer())

  x <- x %% 65536L

  vctrs::new_rcrd(
    list(
      upper = as.raw(x %/% 256L),
      lower = as.raw(x %%  256L)
    ),
    class = "typ_uint16"
  )
}



#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#' Create a uint16 vector
#'
#' @param x integer vector
#'
#' @return uint16 vector
#' @export
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
uint16 <- function(x = integer()) {
  x <- vctrs::vec_cast(x, integer())
  new_uint16(x)
}

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#' Test if uint16
#'
#' @param x object
#'
#' @export
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
is_uint16 <- function(x) {
  inherits(x, 'typ_uint16')
}


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#' Convert to uint16
#'
#' @param x object
#'
#' @export
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
as_uint16 <- function(x) {
  vctrs::vec_cast(x, new_uint16())
}


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#' Format a uint16
#'
#' @param x uint16
#' @param ... ignored
#'
#' @export
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
format.typ_uint16 <- function(x, ...) {
  lower <- as.integer(vctrs::field(x, 'lower'))
  upper <- as.integer(vctrs::field(x, 'upper'))

  as.character(upper*256L + lower)
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
vec_ptype_abbr.typ_uint16 <- function(x, ...) {
  "uint16"
}


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#' Coercion
#'
#' @param x,y objects
#' @param ... other arguments
#' @export
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
vec_ptype2.typ_uint16.typ_uint16  <- function(x, y, ...) new_uint16()

#' @rdname vec_ptype2.typ_uint16.typ_uint16
#' @export
vec_ptype2.typ_uint16.integer <- function(x, y, ...) new_uint16()

#' @rdname vec_ptype2.typ_uint16.typ_uint16
#' @export
vec_ptype2.integer.typ_uint16 <- function(x, y, ...) integer()

#' @rdname vec_ptype2.typ_uint16.typ_uint16
#' @export
vec_ptype2.typ_uint16.double <- function(x, y, ...) new_uint16()

#' @rdname vec_ptype2.typ_uint16.typ_uint16
#' @export
vec_ptype2.double.typ_uint16 <- function(x, y, ...) double()




#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#' Casting
#'
#' @param x object
#' @param to destination prototype
#' @param ... other arguments
#' @export
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
vec_cast.typ_uint16.typ_uint16  <- function(x, to, ...) x

#' @rdname vec_cast.typ_uint16.typ_uint16
#' @export
vec_cast.typ_uint16.integer <- function(x, to, ...) uint16(x)

#' @rdname vec_cast.typ_uint16.typ_uint16
#' @export
vec_cast.integer.typ_uint16 <- function(x, to, ...) {
  as.integer(field(x, 'lower')) + as.integer(field(x, 'upper')) * 256L
}

#' @rdname vec_cast.typ_uint16.typ_uint16
#' @export
vec_cast.typ_uint16.double <- function(x, to, ...) uint16(x)

#' @rdname vec_cast.typ_uint16.typ_uint16
#' @export
vec_cast.double.typ_uint16 <- function(x, to, ...) {
  as.integer(field(x, 'lower')) + as.integer(field(x, 'upper')) * 256L
}

#' @rdname vec_cast.typ_uint16.typ_uint16
#' @export
vec_cast.character.typ_uint16 <- function(x, to, ...) {
  lower <- as.integer(vctrs::field(x, 'lower'))
  upper <- as.integer(vctrs::field(x, 'upper'))

  as.character(upper*256L + lower)
}

# nocov end

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#' Math function calls
#'
#' @param .fn function name as string
#' @param .x  object
#' @param ... other arguments to \code{.fn}
#'
#' @export
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
vec_math.typ_uint16 <- function(.fn, .x, ...) {
  .fn <- getExportedValue("base", .fn)
  .fn(vctrs::vec_cast(.x, integer()), ...)
}


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#' Arithmetic ops
#'
#' @param op  function
#' @param x,y lhs, rhs
#' @param ... ignored
#'
#' @export
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
vec_arith.typ_uint16 <- function(op, x, y, ...) {
  args <- vec_recycle_common(x, y)
  op_fn <- getExportedValue("base", op)
  new_uint16(
    op_fn(
      vctrs::vec_cast(args[[1L]], integer()),
      vctrs::vec_cast(args[[2L]], integer())
    )
  )
}








