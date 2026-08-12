module i2c_slave (
    input        clk,
    input        reset,
    input        scl,
    inout        sda,

    output reg [7:0] received_data,
    output reg       data_valid
);

    reg [7:0] shift_reg;
    reg [3:0] bit_count;

    reg sda_out;
    reg sda_oe;

    assign sda = sda_oe ? sda_out : 1'bz;

    always @(posedge scl or posedge reset) begin

        if (reset) begin
            shift_reg    <= 8'd0;
            received_data <= 8'd0;
            bit_count    <= 4'd0;
            data_valid   <= 1'b0;
            sda_out      <= 1'b0;
            sda_oe       <= 1'b0;
        end

        else begin

            data_valid <= 1'b0;

            if (bit_count < 8) begin

                shift_reg[7-bit_count] <= sda;
                bit_count <= bit_count + 1'b1;

            end

            else begin

                received_data <= shift_reg;
                data_valid    <= 1'b1;
                bit_count     <= 4'd0;
            end

        end

    end

endmodule