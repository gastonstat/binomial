context("Tests of auxiliary functions")

test_that("aux_mean", {

  expect_equal(aux_mean(0, 0), 0)
  expect_equal(aux_mean(1, 0.5), 0.5)
  expect_equal(aux_mean(10, 0.3), 3)
})


test_that("aux_variance", {

  expect_equal(aux_variance(0, 0), 0)
  expect_equal(aux_variance(1, 0.5), 0.25)
  expect_equal(aux_variance(10, 0.3), 2.1)
})


test_that("aux_mode", {

  expect_equal(aux_mode(10, 0.3), 3)
  expect_equal(aux_mode(5, 0.5), c(2, 3))
  expect_equal(aux_mode(10, 0.5), 5)
})

