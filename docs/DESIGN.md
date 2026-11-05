# Technical design

A free-running eight-slot counter selects a four-bit gate mask from a packed 32-bit schedule. An eligible queue wins priority arbitration, and its port is locked until its TLAST handshake, even if the gate closes while that frame is being transferred. The upstream source retains valid and payload during stalls; frame ownership remains locked until TLAST.

## Integration profile

The scheduling datapath selects an open queue using configured gate slots, maintaining frame ownership through TLAST and downstream stalls. Schedule configuration remains stable during traffic.
