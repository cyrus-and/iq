#' In-phase component of an I/Q sample
#'
#' @param iq I/Q complex value.
#'
#' @export
InPhase <- function(iq) {
  return(Re(iq))
}

#' Quadrature component of an I/Q sample
#'
#' @param iq I/Q complex value.
#'
#' @export
Quadrature <- function(iq) {
  return(Im(iq))
}

#' Magnitude of an I/Q sample
#'
#' @param iq I/Q complex value.
#'
#' @export
Magnitude <- function(iq) {
  return(Mod(iq))
}

#' Phase of an I/Q sample
#'
#' @param iq I/Q complex value.
#'
#' @export
Phase <- function(iq) {
  return(Arg(iq))
}

#' Power of an I/Q sample
#'
#' @param iq I/Q complex value.
#'
#' @export
Power <- function(iq) {
  return(20 * log10(Mod(iq))) # squared magnitude
}
