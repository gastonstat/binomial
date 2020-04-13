context("Tests of checker functions")

test_that("check_trials with ok input", {

  expect_true(check_trials(0))
  expect_true(check_trials(1))
  expect_true(check_trials(10))
})


test_that("check_trials fails with invalid input", {

  expect_error(check_trials(-1))
  expect_error(check_trials(NA))
  expect_error(check_trials(2.3))
})


test_that("check_prob with ok input", {

  expect_true(check_prob(0))
  expect_true(check_prob(1))
  expect_true(check_prob(0.5))
})


test_that("check_prob fails with invalid input", {

  expect_error(check_prob(1.0001))
  expect_error(check_prob(-0.00001))
  expect_error(check_prob(NA))
})


test_that("check_success with ok input", {

  expect_true(check_success(0, 0))
  expect_true(check_success(1, 1))
  expect_true(check_success(0, 3))
  expect_true(check_success(0:3, 3))
})


test_that("check_success fails with invalid input", {

  expect_error(check_success(3, 2))
  expect_error(check_success(5, 4))
})
