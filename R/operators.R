#' In-phase component of an I/Q sample
#'
#' @param iq I/Q complex value.
#'
#' @return In-phase component of an I/Q sample.
#'
#' @export
InPhase <- function(iq) {
  return(Re(iq))
}

#' Quadrature component of an I/Q sample
#'
#' @param iq I/Q complex value.
#'
#' @return Quadrature component of an I/Q sample.
#'
#' @export
Quadrature <- function(iq) {
  return(Im(iq))
}

#' Magnitude of an I/Q sample
#'
#' @param iq I/Q complex value.
#'
#' @return Magnitude of an I/Q sample.
#'
#' @export
Magnitude <- function(iq) {
  return(Mod(iq))
}

#' Phase of an I/Q sample
#'
#' @param iq I/Q complex value.
#'
#' @return Phase of an I/Q sample.
#'
#' @export
Phase <- function(iq) {
  return(Arg(iq))
}

#' Power of an I/Q sample
#'
#' @param iq I/Q complex value.
#'
#' @return Power of an I/Q sample.
#'
#' @export
Power <- function(iq) {
  return(20 * log10(Mod(iq))) # squared magnitude
}
