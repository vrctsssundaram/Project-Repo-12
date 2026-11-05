# Interface summary

| Field | Definition |
|---|---|
| Queues | Four independent 32-bit ready/valid data streams with per-port last markers |
| `cfg_gate_schedule` | Bits `[4*s+3:4*s]` open queues for slot `s` (0–7) |
| `cfg_slot_cycles` | Clock cycles per slot; minimum effective value 2 |
| Output | One selected 32-bit stream with TVALID/TREADY/TLAST |
| Status | Slot index, effective gate mask, transferred-beat count |

## Integration profile

The scheduling datapath selects an open queue using configured gate slots, maintaining frame ownership through TLAST and downstream stalls. Schedule configuration remains stable during traffic.
