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
    error("The magic number doesn't match") 
  # Detect the type of data
  type = as.character(readBin(file, "raw", n = 1, size = 1, endian = endian))
  if (type %in% c("08", "09")) size = 1
  else if (type == "08") size = 2
  else if (type %in% c("0C",  "0D")) size = 4
  else error("Type byte found is not supported")
  # Get the number of dimensions
  number_dim = as.integer(readBin(file, "raw", n = 1, size = 1, endian = endian))
  # Get the actual dimensions
  dim = numeric(number_dim)
  for (i in seq_along(dim))
  { dim[i] = readBin(file, "integer", n = 1, size = 4, endian = endian)
  } 
  # Read the data  
  data = readBin(file, "integer", n = prod(dim),
                    size = size, signed = F)
  mat = array(data, dim=dim[length(dim):1])
  close(file)
  return(aperm(mat))
}
