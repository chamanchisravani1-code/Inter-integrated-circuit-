module i2c_master (
    input        clk,
    input        reset,
    input        start,
    input        rw,
    input  [6:0] slave_addr,
    input  [7:0] data_in,

    output reg [7:0] data_out,
    output reg       busy,
    output reg       done,

    output reg       scl,
    inout            sda
);

    reg sda_out;
    reg sda_oe;

    assign sda = sda_oe ? sda_out : 1'bz;

    reg [3:0] bit_count;
    reg [7:0] shift_reg;

    reg [3:0] state;

    localparam IDLE      = 4'd0;
    localparam START     = 4'd1;
    localparam ADDRESS   = 4'd2;
    localparam ACK_ADDR  = 4'd3;
    localparam WRITE_DATA = 4'd4;
    localparam ACK_DATA  = 4'd5;
    localparam STOP      = 4'd6;
    localparam DONE      = 4'd7;

    always @(posedge clk or posedge reset) begin

        if (reset) begin
            scl       <= 1'b1;
            sda_out   <= 1'b1;
            sda_oe    <= 1'b1;
            bit_count <= 4'd0;
            shift_reg <= 8'd0;
            data_out  <= 8'd0;
            busy      <= 1'b0;
            done      <= 1'b0;
            state     <= IDLE;
        end

        else begin

            done <= 1'b0;

            case (state)

                IDLE: begin
                    scl     <= 1'b1;
                    sda_out <= 1'b1;
                    sda_oe  <= 1'b1;

                    if (start) begin
                        busy      <= 1'b1;
                        shift_reg <= {slave_addr, rw};
                        bit_count <= 4'd7;
                        state     <= START;
                    end
                end

                START: begin
                    sda_out <= 1'b0;
                    scl     <= 1'b0;
                    state   <= ADDRESS;
                end

                ADDRESS: begin
                    sda_out <= shift_reg[bit_count];
                    scl     <= ~scl;

                    if (bit_count == 0 && scl == 1'b0)
                        state <= ACK_ADDR;
                    else if (scl == 1'b1)
                        bit_count <= bit_count - 1'b1;
                end

                ACK_ADDR: begin
                    sda_oe <= 1'b0;
                    scl    <= ~scl;

                    if (scl == 1'b0) begin
                        sda_oe  <= 1'b1;
                        shift_reg <= data_in;
                        bit_count <= 4'd7;
                        state <= WRITE_DATA;
                    end
                end

                WRITE_DATA: begin
                    sda_out <= shift_reg[bit_count];
                    scl     <= ~scl;

                    if (bit_count == 0 && scl == 1'b0)
                        state <= ACK_DATA;
                    else if (scl == 1'b1)
                        bit_count <= bit_count - 1'b1;
                end

                ACK_DATA: begin
                    sda_oe <= 1'b0;
                    scl    <= ~scl;

                    if (scl == 1'b0) begin
                        sda_oe <= 1'b1;
                        state  <= STOP;
                    end
                end

                STOP: begin
                    scl     <= 1'b1;
                    sda_out <= 1'b1;
                    state   <= DONE;
                end

                DONE: begin
                    busy <= 1'b0;
                    done <= 1'b1;
                    state <= IDLE;
                end

                default: state <= IDLE;

            endcase
        end
    end

endmodule