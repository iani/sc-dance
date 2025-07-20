// PlayBufTemplate.sc
// Subclass of SynthFuncTemplate for playing buffers.

PlayBufTemplate : SynthFuncTemplate {
	*ar { | buffer, rate |
		^{
			// buffer: a Symbol representing the buffer name (e.g., \columbia)
			// rate: the playback rate multiplier (e.g., from slopePhrase)
			PlayBuf.ar(1, buffer.buffer, BufRateScale.kr(buffer.buffer) * rate, 1, 0, 1);
		}
	}
}