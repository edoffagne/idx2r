

test_that('Error is returned if x is character', {
  m = matrix(as.character(1:16), nrow = 4)
  file_name = "error.idx"
  expect_error(writeIdx(m, file_name))
})


test_that('Error is returned if x is not a matrix or an array', {
  m = 1:16
  file_name = "error.idx"
  expect_error(writeIdx(m, file_name))
})

