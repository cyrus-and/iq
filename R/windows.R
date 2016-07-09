#' Rectangular window function
#'
#' @param size Window width in number of samples.
#'
#' @family FFT
#'
#' @export
Rectangular <- function(size) {
  window <- list(
    'size' = size,
    'value' = function(x) rep.int(1, length(x))
  )
  return(window)
}

#' Triangular window function
#'
#' @inheritParams Rectangular
#'
#' @family FFT
#'
#' @export
Triangular <- function(size) {
  window <- list(
    'size' = size,
    'value' = function(x) 1 - abs((x - (size - 1) / 2) / (size / 2))
  )
  return(window)
}

#' Hamming window function
#'
#' @param alpha Hamming window coefficient.
#' @inheritParams Rectangular
#'
#' @family FFT
#'
#' @export
Hamming <- function(size, alpha = 0.54) {
  window <- list(
    'size' = size,
    'value' = function(x) alpha - (1 - alpha) * cos((2 * pi * x) / (size - 1))
  )
  return(window)
}

#' Hanning window function
#'
#' @inheritParams Rectangular
#'
#' @family FFT
#'
#' @export
Hanning <- function(size) {
  return(Hamming(size, 0.5))
}
