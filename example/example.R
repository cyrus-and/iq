library(iq)

# set up some fancy colors
plot.color <- '#00f900'
par(bg = '#000000', fg = '#666666', col.main = '#ff4200', col.axis = '#ffad00', col.lab = '#666666')
palette <- colorRampPalette(c('#000000', '#0074ff', '#00f900', '#ff4200'))(100)

# set up the plot layout
layout(matrix(c(1:4, 5, 5, 6, 7), nrow = 4, ncol = 2))
par(mar = c(4, 4, 2, 2), mgp = c(2.5, 1, 0))

# load the signal from file
signal <- iq::FromFile(file.name = 'example/signal.bin.bz2',
                       carrier.frequency = 433.8e6, sample.rate = 1e6)

# extract some I/Q values from the signal in the given range (using at most 1000 samples)
range <- iq::SampleRange(signal, from.time = 0.033, to.time = 0.040, max.samples = 1e3)

# plot the components for the above range
plot(range$time, iq::Magnitude(range$iq), type = 'l', col = plot.color,
     main = 'Magnitude', xlab = 'Time (s)', ylab = '')
plot(range$time, iq::Phase(range$iq), type = 'l', col = plot.color,
     main = 'Phase', xlab = 'Time (s)', ylab = 'Radians')
plot(range$time, iq::InPhase(range$iq), type = 'l', col = plot.color,
     main = 'In-phase', xlab = 'Time (s)', ylab = '')
plot(range$time, iq::Quadrature(range$iq), type = 'l', col = plot.color,
     main = 'Quadrature', xlab = 'Time (s)', ylab = '')

# plot the spectrogram at the given range using a Hamming window 1024 samples wide
from.time <- 0.1
to.time <- 0.5
spectrogram <- iq::Spectrogram(signal, from.time, to.time, iq::Hamming(1024))
spectrogram$y <- spectrogram$y / 1e6
image(spectrogram, col = palette,
      xlab = 'Time (s)', ylab = 'Frequency (MHz)', main = 'Spectrogram')

# plot the spectrum at the given times using a rectangular window 1024 samples wide (default)
at.time <- 0.1
spectrum <- iq::Spectrum(signal, at.time)
plot(spectrum$frequency / 1e6, spectrum$power, type = 'l', ylim = c(-100, 0),
     col = plot.color, xlab = 'Frequency (MHz)', ylab = 'Power (dB)',
     main = paste0('Power spectrum at ', at.time, 's'))

at.time <- 0.3
spectrum <- iq::Spectrum(signal, at.time)
plot(spectrum$frequency / 1e6, spectrum$power, type = 'l', ylim = c(-100, 0),
     col = plot.color, xlab = 'Frequency (MHz)', ylab = 'Power (dB)',
     main = paste0('Power spectrum at ', at.time, 's'))
