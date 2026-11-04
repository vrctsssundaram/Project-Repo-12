module tsn_timegate (
    input  wire         clk,
    input  wire         rst_n,
    input  wire         enable,
    input  wire [15:0]  cfg_slot_cycles,
    input  wire [31:0]  cfg_gate_schedule,
    input  wire [127:0] s_data,
    input  wire [3:0]   s_valid,
    input  wire [3:0]   s_last,
    output reg  [3:0]   s_ready,
    output reg  [31:0]  m_data,
    output reg          m_valid,
    output reg          m_last,
    input  wire         m_ready,
    output reg  [2:0]   slot_index,
    output wire [3:0]   gate_mask,
    output reg  [31:0]  transmitted_beats
);
    reg [15:0] cycle_in_slot;
    reg locked;
    reg [1:0] locked_port;
    reg pick_valid;
    reg [1:0] pick_port;
    reg [1:0] chosen_port;
    reg chosen_valid;
    integer k;
    wire [15:0] slot_length = cfg_slot_cycles < 2 ? 16'd2 : cfg_slot_cycles;
    assign gate_mask = enable ? cfg_gate_schedule[slot_index*4 +: 4] : 4'b0000;

    always @* begin
        pick_valid = 0;
        pick_port = 0;
        for (k=0;k<4;k=k+1)
            if (!pick_valid && gate_mask[k] && s_valid[k]) begin
                pick_valid = 1;
                pick_port = k[1:0];
            end
        chosen_valid = locked || pick_valid;
        chosen_port = locked ? locked_port : pick_port;
        m_data = 0;
        m_last = 0;
        m_valid = 0;
        s_ready = 0;
        if (chosen_valid) begin
            m_data = s_data[chosen_port*32 +: 32];
            m_last = s_last[chosen_port];
            m_valid = s_valid[chosen_port];
            s_ready[chosen_port] = m_ready;
        end
    end

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            cycle_in_slot <= 0;
            slot_index <= 0;
            locked <= 0;
            locked_port <= 0;
            transmitted_beats <= 0;
        end else begin
            if (cycle_in_slot == slot_length-1'b1) begin
                cycle_in_slot <= 0;
                slot_index <= slot_index + 1'b1;
            end else cycle_in_slot <= cycle_in_slot + 1'b1;

            if (chosen_valid && m_valid) begin
                if (!locked) begin
                    locked_port <= chosen_port;
                    locked <= !(m_ready && m_last);
                end else if (m_ready && m_last) locked <= 0;
                if (m_ready) transmitted_beats <= transmitted_beats + 1'b1;
            end
        end
    end
endmodule
