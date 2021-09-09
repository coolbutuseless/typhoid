

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#' New word
#'
#' @param x vector of doubles
#' @param decimals how many decimals to show in output. default: 3
#'
#' @import vctrs
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
new_numberwang <- function(x = double(), decimals = 3) {
  vctrs::vec_assert(x, double())

  vctrs::new_vctr(x, decimals = decimals, class = "typ_numberwang")
}

decimals <- function(x) attr(x, 'decimals', exact = TRUE)


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#' Create a vector of \code{numberwang} values from double values
#'
#' @param x vector of doubles
#' @param decimals how many decimals to show in output. default: 3
#'
#' @return numberwang vector
#' @export
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
numberwang <- function(x = double(), decimals = 3) {
  x <- vctrs::vec_cast(x, double())
  new_numberwang(x, decimals = decimals)
}


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#' Test if object is \code{numberwang}
#'
#' @param x object
#'
#' @return logical
#' @export
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
is_numberwang <- function(x) {
  inherits(x, "typ_numberwang")
}

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#' Convert to numberwang
#'
#' @param x vector
#' @param ... ignored
#'
#' @export
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
as_numberwang <- function(x, ...) {
  UseMethod("as_numberwang")
}


#' @rdname as_numberwang
#' @export
as_numberwang.default <- function(x, ...) {
  vctrs::vec_cast(x, new_numberwang())
}

#' @rdname as_numberwang
#' @export
as_numberwang.character <- function(x, ...) {
  words <- numberwang::words_to_num(x)
  new_numberwang(words)
}

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#' Format a \code{numberwang} value
#'
#' @param x object
#' @param ... ignored
#'
#' @export
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
format.typ_numberwang <- function(x, ...) {
  res <- numberwang::num_to_words(vec_data(x), decimals = decimals(x))
  dQuote(res, "'")
}


# nocov start
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#' Coercion
#'
#' @param x,y objects
#' @param ... other arguments
#' @export
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
vec_ptype2.typ_numberwang.typ_numberwang  <- function(x, y, ...) new_numberwang()

#' @rdname vec_ptype2.typ_numberwang.typ_numberwang
#' @export
vec_ptype2.typ_numberwang.double <- function(x, y, ...) new_numberwang()

#' @rdname vec_ptype2.typ_numberwang.typ_numberwang
#' @export
vec_ptype2.double.typ_numberwang <- function(x, y, ...) double()

#' @rdname vec_ptype2.typ_numberwang.typ_numberwang
#' @export
vec_ptype2.typ_numberwang.integer <- function(x, y, ...) new_numberwang()

#' @rdname vec_ptype2.typ_numberwang.typ_numberwang
#' @export
vec_ptype2.integer.typ_numberwang <- function(x, y, ...) integer()



#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#' Casting
#'
#' @param x object
#' @param to destination prototype
#' @param ... other arguments
#' @export
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
vec_cast.typ_numberwang.typ_numberwang  <- function(x, to, ...) x

#' @rdname vec_cast.typ_numberwang.typ_numberwang
#' @export
vec_cast.typ_numberwang.double <- function(x, to, ...) new_numberwang(x)

#' @rdname vec_cast.typ_numberwang.typ_numberwang
#' @export
vec_cast.double.typ_numberwang <- function(x, to, ...) vctrs::vec_data(x)

#' @rdname vec_cast.typ_numberwang.typ_numberwang
#' @export
vec_cast.typ_numberwang.integer <- function(x, to, ...) new_numberwang(as.numeric(x))

#' @rdname vec_cast.typ_numberwang.typ_numberwang
#' @export
vec_cast.integer.typ_numberwang <- function(x, to, ...) as.integer(vctrs::vec_data(x))

#' @rdname vec_cast.typ_numberwang.typ_numberwang
#' @export
vec_cast.character.typ_numberwang <- function(x, to, ...) {
  numberwang::num_to_words(vctrs::vec_data(x), decimals = decimals(x))
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
vec_math.typ_numberwang <- function(.fn, .x, ...) {
  .fn <- getExportedValue("base", .fn)
  new_numberwang(
    .fn(vctrs::vec_data(.x), ...)
  )
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
vec_arith.typ_numberwang <- function(op, x, y, ...) {
  args <- vec_recycle_common(x, y)
  op_fn <- getExportedValue("base", op)
  new_numberwang(
    op_fn(
      vctrs::vec_data(args[[1L]]),
      vctrs::vec_data(args[[2L]])
    )
  )
}









