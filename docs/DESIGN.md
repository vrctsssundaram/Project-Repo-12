# Technical design

A free-running eight-slot counter selects a four-bit gate mask from a packed 32-bit schedule. An eligible queue wins priority arbitration, and its port is locked until its TLAST handshake, even if the gate closes while that frame is being transferred. The upstream source must hold valid and payload while stalled; the module neither stores nor preempts frames.

## Scope boundary

This is a scheduling primitive, not a complete IEEE TSN switch: no PTP synchronization, guard bands, bandwidth reservation, frame preemption, or standards-conformance claim. Keep configuration stable during active traffic.
