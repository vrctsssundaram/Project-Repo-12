module tb_tsn_timegate;
    reg clk=0; always #5 clk=~clk;
    reg rst_n=0,enable=1,m_ready=0;
    reg [15:0] cfg_slot_cycles=10;
    reg [31:0] cfg_gate_schedule=32'h00000021;
    reg [127:0] s_data=0;
    reg [3:0] s_valid=0,s_last=0;
    wire [3:0] s_ready,gate_mask;
    wire [31:0] m_data,transmitted_beats;
    wire m_valid,m_last;
    wire [2:0] slot_index;
    integer seen=0,port0_beats=0;
    tsn_timegate dut(.*);
    always @(posedge clk) if(rst_n) begin
        if(m_valid && m_ready) begin
            case(seen)
                0: if(m_data!==32'haaaa0001 || m_last) $fatal(1,"First frame beat");
                1: if(m_data!==32'haaaa0002 || !m_last) $fatal(1,"Locked frame beat");
                2: if(m_data!==32'hbbbb0001 || !m_last) $fatal(1,"Second queue frame");
                default: $fatal(1,"Unexpected beat");
            endcase
            seen = seen+1;
        end
        if(s_valid[0] && s_ready[0]) begin
            port0_beats = port0_beats+1;
            if(port0_beats==1) begin
                s_data[31:0] <= 32'haaaa0002;
                s_last[0] <= 1;
            end else s_valid[0] <= 0;
        end
        if(s_valid[1] && s_ready[1]) s_valid[1] <= 0;
    end
    initial begin
        s_data[31:0]=32'haaaa0001;
        s_data[63:32]=32'hbbbb0001;
        s_valid=4'b0011;
        s_last=4'b0010;
        repeat(3) @(negedge clk);rst_n=1;
        repeat(13) @(negedge clk);
        if(slot_index!==1 || !m_valid || m_data!==32'haaaa0001 || m_last)
            $fatal(1,"Frame selection changed while stalled");
        m_ready=1;
        wait(seen==3);
        @(negedge clk);
        if(transmitted_beats!==3 || port0_beats!==2)
            $fatal(1,"Counters");
        $display("PASS: scheduled gates, queue priority, backpressure and frame-contiguous output");
        $finish;
    end
    initial begin #100000;$fatal(1,"Watchdog");end
endmodule
