module i2c_top (
    input        clk,
    input        reset,
    input        start,
    input        rw,
    input  [6:0] slave_addr,
    input  [7:0] data_in,

    output [7:0] received_data,
    output       data_valid,
    output       busy,
    output       done
);

    wire scl;
    wire sda;

    i2c_master master (
        .clk(clk),
        .reset(reset),
        .start(start),
        .rw(rw),
        .slave_addr(slave_addr),
        .data_in(data_in),
        .data_out(),
        .busy(busy),
        .done(done),
        .scl(scl),
        .sda(sda)
    );

    i2c_slave slave (
        .clk(clk),
        .reset(reset),
        .scl(scl),
        .sda(sda),
        .received_data(received_data),
        .data_valid(data_valid)
    );

endmodule