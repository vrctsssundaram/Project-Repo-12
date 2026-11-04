# TSN-TimeGate

Four-port time-slot traffic scheduler with frame-contiguous forwarding.

## Features

- Eight configurable schedule slots with four gate bits per slot
- Programmable slot duration in clock cycles
- Priority arbitration among currently open queues
- Frame lock through gate transitions and output backpressure

## Verification

Run `make test` for the self-checking regression or `make synth` for a synthesis check. See `docs/` for the design, interface, procedure and recorded results.

This is a bounded RTL subsystem with explicit limitations; no board or standards certification is claimed.

Project owner: Sundaram S S.
