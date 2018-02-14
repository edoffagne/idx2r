

test_that('Double matrix can be written/read to IDX', {
  nr = 4
  m = matrix(round(rnorm(nr*nr),5), nrow=nr)
  file = "m16id.idx"
  write_idx(m, file)
  mr = read_idx(file) 
  for (i in 1:(nr*nr)) expect_equal(m[i], mr[i], tolerance = 0.0001)  
})
