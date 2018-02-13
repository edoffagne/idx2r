#' Read an IDX file
#'
#' This function allows to read an IDX file
#' 
#' @usage read_idx(x, file_name) 
#' @param file_name character vector containing the name of
#'        the file to be read
#' @param endian wether the file has big or little endian
#' @rdname write_idx
#' @export

read_idx = function(file_name, endian = "big")
{ file = file(file_name, "rb")
  # Check that the 2 first bytes contain the magic number  
  magic_1 = readBin(file, "raw", n = 1, size = 1, endian = endian)
  magic_2 = readBin(file, "raw", n = 1, size = 1, endian = endian)
  if (any(as.character(c(magic_1, magic_2)) != c("00", "00")))
    stop("The magic number doesn't match") 
  # Detect the type of data
  signed = TRUE
  type = as.character(readBin(file, "raw", n = 1, size = 1, endian = endian))
  if (type == "08")
  { size = 1
    signed = FALSE
    what = "integer"
  }
  else if (type == "09")
  { size = 1
    what = "integer"
  }
  else if (type == "0b")
  { size = 2
    what = "integer"
  }
  else if (type =="0c")
  { size = 4 
    what = "integer"
  }
   else if (type =="0d")
  { size = 4 
    what = "numeric"
  }
  else if (type == "0e")
  { size = 8
    what = "double"
  }
  else stop("Type byte found is not supported")
  # Get the number of dimensions
  number_dim = as.integer(readBin(file, "raw", n = 1, size = 1, endian = endian))
  # Get the actual dimensions
  dim = numeric(number_dim)
  for (i in seq_along(dim))
  { dim[i] = readBin(file, "integer", n = 1, size = 4, endian = endian)
  } 
  # Read the data  
  data = readBin(file, what, n = prod(dim),
                    size = size, signed = signed)
  mat = array(data, dim=dim[length(dim):1])
  close(file)
  return(aperm(mat))
}
