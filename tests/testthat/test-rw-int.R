

test_that('Integer matrix can be written to IDX', {
  nr = 4
  m = matrix(1:(nr*nr), nrow=nr)
  file = "m16i.idx"
  write_idx(m, file)
  mr = read_idx(file) 
  for (i in 1:(nr*nr)) expect_equal(m[i], mr[i])  
})
