#' Normalize raw samples
#'
#' Convert the given samples from a raw vector of unisgned bytes to numerics in
#' a range from -1 to 1 (inclusive).
#'
#' @param raw.vector Input
#'
#' @return A vector of normalized samples.
NormalizeRawSamples <- function(raw.vector) {
  int.samples <- readBin(raw.vector, what = 'integer',
                         size = 1, signed = F,
                         n = length(raw.vector))
  float.samples <- (int.samples / 255 - 0.5) * 2
  return(float.samples)
}
