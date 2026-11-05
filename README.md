# Time-gated frame scheduler

Four-port time-slot traffic scheduler with frame-contiguous forwarding.

## Features

- Eight configurable schedule slots with four gate bits per slot
- Programmable slot duration in clock cycles
- Priority arbitration among currently open queues
- Frame lock through gate transitions and output backpressure

## Verification

Run `make test` for the self-checking regression or `make synth` for a synthesis check. See `docs/` for the design, interface, procedure and recorded results.

**Architecture:** Eight-slot four-port gate scheduler with frame-contiguous priority forwarding.

Project owner: Sundaram S S.
