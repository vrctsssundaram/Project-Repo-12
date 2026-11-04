IVERILOG ?= iverilog
VVP ?= vvp
YOSYS ?= yosys
.PHONY: test synth clean
test:
	mkdir -p build
	$(IVERILOG) -g2012 -Wall -s tb_tsn_timegate -o build/sim rtl/tsn_timegate.sv tb/tb_tsn_timegate.sv
	$(VVP) build/sim
synth:
	mkdir -p build
	$(YOSYS) -Q -T -l build/synthesis.log -p 'read_verilog -sv rtl/tsn_timegate.sv; hierarchy -check -top tsn_timegate; synth -top tsn_timegate; stat'
clean:
	rm -f build/sim
