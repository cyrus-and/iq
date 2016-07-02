#' Create a signal representation from a raw vector of bytes.
#'
#' The raw vector must be a sequence of I/Q values (1 byte per component).
#'
#' @param raw.vector Input vector.
#' @param sample.rate Sample rate.
#' @param carrier.frequency Carrier frequency.
#'
#' @return A signal representation.
FromRawVector <- function(raw.vector, sample.rate, carrier.frequency = NA) {
  # compute the duration in seconds and the number of samples
  n.samples <- length(raw.vector) / 2
  duration <- (n.samples - 1) / sample.rate
  # build the signal representation
  signal <- list(
    raw.vector        = raw.vector,
    sample.rate       = sample.rate,
    carrier.frequency = carrier.frequency,
    n.samples         = trunc(length(raw.vector) / 2),
    duration          = (n.samples - 1) / sample.rate
  )
  return(signal)
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
