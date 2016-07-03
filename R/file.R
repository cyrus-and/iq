#' Load a binary file into a raw vector.
#'
#' Accordingly to the file extension, the content of the file is passed to
#' \code{\link{memDecompress}}.
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

#' Create a signal representation from a file.
#'
#' @param file.name Input file name.
#' @inheritParams FromRawVector
#'
#' @return A signal representation.
#'
#' @export
FromFile <- function(file.name, sample.rate, carrier.frequency = NA) {
  raw.vector <- LoadRawFile(file.name)
  signal <- FromRawVector(raw.vector, sample.rate, carrier.frequency)
  return(signal)
}

#' Write a signal representation to a file.
#'
#' The file is compressed according to its extension.
#'
#' @param signal Source signal.
#' @param file.name Output file name.
#'
#' @seealso \code{\link{base::memCompress}}
#'
#' @export
ToFile <- function(signal, file.name) {
  # write to the proper connection according to the file extension
  extension <- tail(strsplit(file.name, split = '\\.')[[1]], n = 1)
  con.type <- switch(extension, gz = gzfile, bz2 = bzfile, xz = xzfile, file)
  con <- con.type(file.name, 'wb')
  writeBin(signal$raw.vector, con, useBytes = T)
  close(con)
}
