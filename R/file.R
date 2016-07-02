#' Load a binary file into a raw vector.
#'
#' Accordingly to the file extension, the content of the file is passed to
#' \code{memDecompress}.
#'
#' @param file.name Input file name.
#'
#' @return A raw vector containing the file.
LoadRawFile <- function(file.name) {
  # read the whole file
  file.size <- file.info(file.name)$size
  raw.samples <- readBin(file.name, what = 'raw', n = file.size)
  # extract the extension and attempt decompression if needed
  # XXX gzip never works: internal error -3 in memDecompress(2)
  extension <- tail(strsplit(file.name, split = '\\.')[[1]], n = 1)
  compression <- switch(extension, gz = 'gzip', bz2 = 'bzip2', xz = 'xz', 'none')
  raw.samples <- memDecompress(raw.samples, type = compression)
  return(raw.samples)
}
