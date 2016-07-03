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

#' Create a new signal by resampling a portion of another
#'
#' Range parameters are interpreted by \code{\link{SampleIndexRange}}.
#'
#' @param new.sample.rate New sample rate.
#' @inheritParams SampleIndexRange
#'
#' @return A resampled signal.
#'
#' @export
Resample <- function(signal, new.sample.rate, first.sample.index = NA,
                     last.sample.index = NA, from.time = NA, to.time = NA) {
  # compute the sample index range
  sample.index.range <- SampleIndexRange(signal, first.sample.index, last.sample.index,
                                         from.time, to.time, sample.rate = new.sample.rate)
  # check original signal boundaries
  if (sample.index.range[1] < 1 || tail(sample.index.range , n = 1) > signal$n.samples) {
    stop("Cannot resample outside the signal boundaries")
  }
  i.indices <- sample.index.range * 2 - 1
  q.indices <- sample.index.range * 2
  indices <- c(rbind(i.indices, q.indices))
  # update and return the signal (a copy of)
  signal$raw.vector <- signal$raw.vector[indices]
  signal$sample.rate <- new.sample.rate
  signal$n.samples <- length(sample.index.range)
  signal$duration <- length(sample.index.range) / new.sample.rate
  return(signal)
}
