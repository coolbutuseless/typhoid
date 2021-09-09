test_that("fixedpt works", {

  res <- fixedpt(12) * fixedpt(12)
  expect_equal(as.numeric(res), 144)

  res <- fixedpt(65535) + 2
  expect_true(is_fixedpt(res))
  expect_equal(
    as.numeric(res),
    65537
  )

  res <- mean(fixedpt(3:6))
  expect_equal(
    as.character(res),
    "4.500"
  )

  res <- as_fixedpt(12)
  expect_true(is_fixedpt(res))
  expect_equal(
    as.character(res),
    "12.000"
  )

  expect_equal(
    format(as_fixedpt(12)),
    "12.000"
  )

})
