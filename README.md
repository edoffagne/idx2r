# Using IDX files with R

[![Build Status](https://travis-ci.org/edoffagne/idx2r.svg?branch=master)](https://travis-ci.org/edoffagne/idx2r)

## Introduction

This package provides functions to convert files to
and from IDX format to arrays in R. IDX is a format
to store vector and arrays in binary format.

Reading IDX format is needed for instance to use 
the [MNIST database of handwritten digits](http://yann.lecun.com/exdb/mnist/) provided by Yann LeCun.

## Usage

This basic example downloads, uncompresses and reads the IDX file from the train set of the MNIST data. 

```shell
library(idx2r)
library(R.utils)
URL = "http://yann.lecun.com/exdb/mnist/"
file_name = "train-images-idx3-ubyte.gz"
download.file(paste0(URL, file_name), "train-images-idx3-ubyte.gz")
gunzip(file_name)
train = read_idx(gsub(pattern = "\\.gz", "", file_name))
dim(train)
```

## Installation

The package can be installed from GitHub with the following command:

```shell
$ R -e "devtools::install_github('edoffagne/idx2r')"
```

The package can also be installed from a CRAN repository from an
R session:

```shell
> install.packages("idx2r")
```




