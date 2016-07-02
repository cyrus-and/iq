#' Frequency scale used to interpret the frequency bins.
#'
#' The resulting frequencies are relative to the carrier frequency of the
#' signal, if present, otherwise to 0.
#'
#' @param signal Source signal.
#' @param window Window used to compute the power spectrum.
#'
#' @return A vector of frequencies \code{window$size} long.
FrequencyScale <- function(signal, window) {
  half.bw <- signal$sample.rate / 2
  frequency <- seq(from = -half.bw, to = half.bw, length.out = window$size)
  # make it absolute if the carrier frequency is available
  if (!is.na(signal$carrier.frequency)) {
    frequency <- frequency + signal$carrier.frequency
  }
  return(frequency)
}

#' Compute the power spectrum of the signal at the given time.
#'
#' @param signal Source signal.
#' @param at.time Time instant.
#' @param window FFT window function.
#'
#' @return A vector of \code{window$size} elements containing the resulting FFT
#'   frequency bins.
#'
#' @family fft
#' @export
Spectrum <- function(signal, at.time, window = Rectangular(1024)) {
  # take window$size samples before the given time
  last.sample.index <- SampleIndexAtTime(at.time, signal$sample.rate)
  first.sample.index <- last.sample.index - window$size + 1
  sample.range <- SampleRange(signal, first.sample.index, last.sample.index)
  # compute FFT after applying the window function
  window.x <- 0:(window$size - 1)
  frequency.bins <- fft(sample.range$iq * window$value(window.x))
  # compute normalized power
  window.size.hz <- signal$sample.rate / window$size
  power <- Power(frequency.bins / window.size.hz)
  # split and swap the FFT result
  power <- c(tail(power, n = window$size / 2), head(power, n = window$size / 2))
  # prepare the frequency scale
  frequency <- FrequencyScale(signal, window)
  # prepare the resulting data frame
  spectrum <- data.frame(frequency, power)
  return(spectrum)
}

#' Compute the spectrogram of the signal at the given time range.
#'
#' @param from.time From time instant.
#' @param to.time To time instant.
#' @param segment.overlap Segment overlap ratio (0 means contiguous segments),
#'   negative values produce spaced segments.
#' @param n.segments Exact number of segments (take precedence over
#'   \code{segment.overlap} which is computed accordingly).
#' @inheritParams Spectrum
#'
#' @return A named list suitable to be printed with \code{image}, \code{x}
#'   element represents the time while \code{y} represents the frequency.
#'
#' @seealso graphics::image
#'
#' @family fft
#' @export
Spectrogram <- function(signal, from.time = 0, to.time = signal$duration,
                        window = Rectangular(1024), segment.overlap = 0, n.segments) {
  # compute the time instants
  if (missing(n.segments)) {
    segment.time <- (window$size / signal$sample.rate) * (1 - segment.overlap)
    time <- seq(from = from.time, to.time, by = segment.time)
  } else {
    time <- seq(from.time, to.time, length.out = n.segments)
  }
  # compute the spectrum of each segment
  power <- matrix(nrow = length(time), ncol = window$size)
  for (i in 1:length(time)) {
    at.time <- time[i]
    spectrum <- Spectrum(signal, at.time, window)
    power[i, ] <- spectrum$power
  }
  # prepare the frequency axis
  frequency <- FrequencyScale(signal, window)
  # prepare the resulting list
  spectrogram <- list(
    x = time,
    y = frequency,
    z = power
  )
  return(spectrogram)
}
