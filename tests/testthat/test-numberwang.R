


test_that("multiplication works", {

  res <- numberwang(27) + numberwang(3)
  expect_true(is_numberwang(res))

  expect_equal(
    as.numeric(res),
    30
  )

  res <- as_numberwang("one thousand") - 1
  expect_equal(
    as.numeric(res),
    999
  )

  expect_equal(
    as.character(res),
    "nine hundred and ninety-nine"
  )

  expect_equal(
    as.numeric(as_numberwang(12)),
    12
  )

  res <- mean(as_numberwang(3:5))
  expect_equal(
    as.numeric(res),
    4
  )

  expect_equal(
    as.character(res),
    "four"
  )

  expect_equal(
    format(res),
    '"four"'
  )

})
