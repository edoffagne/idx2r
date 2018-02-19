
#' Write an array into an IDX file
#'
#' This function allows to write an array into an IDX file.
#' 
#' @usage write_idx(x, file_name, endian = "big") 
#' @param x must be a array or a matrix
#' @param file_name character vector containing the name of
#'        the file to be created
#' @param endian whether the file has "big" or "little" endian.
#' @rdname write_idx
#' @examples
#' m = matrix(1:16, nrow = 4)
#' file_name = file.path(tempdir(),"m.idx")
#' write_idx(m, file_name)    
#' @export

write_idx = function(x, file_name, endian = "big")
{ if (!is.character(file_name)) stop("File_name must be character")
  file = file(file_name, "wb")
  # Check that the 2 first bytes contain the magic number  
  writeBin(as.raw(0), file, size = 1, endian = endian)
  writeBin(as.raw(0), file, size = 1, endian = endian)
  # write the type of data
  if (typeof(x) == "integer")
  { type = 12 
    size = 4 
  }
  else if (typeof(x) == "double")
  { type = 14
    size = 8
  }
  else stop("Type of x must be integer or double")
  writeBin(as.raw(type), file,  size = 1, endian = endian)
  # Get the number of dimensions of x
  if (is.array(x)) dim_x = dim(x)
  else if (is.vector(x)) dim_x = length(x)
  else stop("x must be a vector, a matrix or an array")
  writeBin(as.raw(length(dim_x)), file,  size = 1, endian = endian)
  # Write the actual dimensions
  for (i in dim_x)
  { writeBin(i, file, size = 4, endian = endian)
  }
  # write the data 
  if (length(dim_x) > 1) x = as.vector(aperm(x))
  writeBin(x, file, size = size,  endian = endian)
  close(file)
}

