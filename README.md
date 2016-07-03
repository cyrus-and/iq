iq
==

This package offers a convenient way to parse and analyze I/Q files like those
produced by an [RTL-SDR][rtl-sdr] dongle.

Example
=======

The following is the output obtained by running [example.R](example/example.R).

![Example](http://i.imgur.com/mpL7F4J.png)

Features
========

See the embedded R documentation for the full reference; here is an overview of
the available functions:

 * Load from (`iq::FromFile`) and save to (`iq::ToFile`) plain or compressed
   binary files.

 * Cut and resample a signal (`iq::Resample`).

 * Extract ranges of complex I/Q values from the signal (`iq::SampleRange`)
   on-demand to avoid overloading the available memory.

 * Compute some common operations over complex I/Q values (`iq::Magnitude`,
   `iq::Phase`, etc.).

 * Perform power spectrum analysis (`iq::Spectrum` and `iq::Spectrogram`) of the
   signal using builtin (`iq::Rectangular`, `iq::Hamming`, etc.) or custom
   window functions.

[rtl-sdr]: http://www.rtl-sdr.com/
