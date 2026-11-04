# Verification record

Date: 05 November 2026
Source revision tested: `a9787877bbf41cea9339780601c1548f19b77fa9`
Hosted verification: https://github.com/vrctsssundaram/Project-Repo-12/actions/runs/41900978854

| Measurement | Recorded result |
|---|---|
| SystemVerilog compilation | **PASS** (Icarus Verilog, `-g2012 -Wall`) |
| Directed self-checking simulation | **PASS** (exit code 0) |
| Directed checks | slot advancement, per-port masks, frame lock during gate closure, output backpressure and beat accounting |
| Generic Yosys synthesis | **PASS**; 582 technology-independent cells |
| FPGA/ASIC technology-specific utilization | Not measured |
| Static timing, maximum clock, power | Not measured |
| Physical hardware throughput | Not measured |

The synthesis count is taken from the top-level `stat` section of the hosted generic Yosys run, not a device-mapped area estimate. The directed testbench is bounded and does not constitute exhaustive or formal verification. No artificial waveform, timing, area, or power result is presented as a measurement.
