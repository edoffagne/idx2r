\name{read_idx}
\alias{read_idx}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
%%  ~~function to do ... ~~
}
\description{
%%  ~~ A concise (1-5 lines) description of what the function does. ~~
}
\usage{
read_idx(file_name, endian = "big")
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{file_name}{
%%     ~~Describe \code{file_name} here~~
}
  \item{endian}{
%%     ~~Describe \code{endian} here~~
}
}
\details{
%%  ~~ If necessary, more details than the description above ~~
}
\value{
%%  ~Describe the value returned
%%  If it is a LIST, use
%%  \item{comp1 }{Description of 'comp1'}
%%  \item{comp2 }{Description of 'comp2'}
%% ...
}
\references{
%% ~put references to the literature/web site here ~
}
\author{
%%  ~~who you are~~
}
\note{
%%  ~~further notes~~
}

%% ~Make other sections like Warning with \section{Warning }{....} ~

\seealso{
%% ~~objects to See Also as \code{\link{help}}, ~~~
}
\examples{
##---- Should be DIRECTLY executable !! ----
##-- ==>  Define data, use random,
##--	or do  help(data=index)  for the standard data sets.

## The function is currently defined as
function (file_name, endian = "big") 
{
    file = file(file_name, "rb")
    magic_1 = readBin(file, "raw", n = 1, size = 1, endian = endian)
    magic_2 = readBin(file, "raw", n = 1, size = 1, endian = endian)
    if (any(as.character(c(magic_1, magic_2)) != c("00", "00"))) 
        error("The magic number doesn't match")
    type = as.character(readBin(file, "raw", n = 1, size = 1, 
        endian = endian))
    if (type \%in\% c("08", "09")) 
        size = 1
    else if (type == "08") 
        size = 2
    else if (type \%in\% c("0C", "0D")) 
        size = 4
    else error("Type byte found is not supported")
    number_dim = as.integer(readBin(file, "raw", n = 1, size = 1, 
        endian = endian))
    dim = numeric(number_dim)
    for (i in seq_along(dim)) {
        dim[i] = readBin(file, "integer", n = 1, size = 4, endian = endian)
    }
    data = readBin(file, "integer", n = prod(dim), size = size, 
        signed = F)
    mat = array(data, dim = dim[length(dim):1])
    close(file)
    return(aperm(mat))
  }
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }% use one of  RShowDoc("KEYWORDS")
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
