

test_that("uint16 works", {

  res <- uint16(12) * uint16(12)
  expect_equal(as.numeric(res), 144)

  res <- uint16(65535) + 2
  expect_true(is_uint16(res))
  expect_equal(
    as.numeric(res),
    1
  )

  res <- mean(uint16(3:6))
  expect_equal(
    as.character(res),
    "4.5"
  )

  res <- as_uint16(12)
  expect_true(is_uint16(res))
  expect_equal(
    as.character(res),
    "12"
  )

  expect_equal(
    format(as_uint16(12)),
    "12"
  )

})
