`timescale 1ns/1ps

module i2c_tb;

    reg clk;
    reg reset;
    reg start;
    reg rw;

    reg [6:0] slave_addr;
    reg [7:0] data_in;

    wire [7:0] received_data;
    wire data_valid;
    wire busy;
    wire done;

    i2c_top uut (
        .clk(clk),
        .reset(reset),
        .start(start),
        .rw(rw),
        .slave_addr(slave_addr),
        .data_in(data_in),
        .received_data(received_data),
        .data_valid(data_valid),
        .busy(busy),
        .done(done)
    );

    always #5 clk = ~clk;

    initial begin

        $dumpfile("i2c.vcd");
        $dumpvars(0, i2c_tb);

        clk = 0;
        reset = 1;
        start = 0;
        rw = 0;

        slave_addr = 7'b1010000;
        data_in = 8'hA5;

        #20;

        reset = 0;

        $display("---------------------------------------");
        $display("       I2C MASTER-SLAVE SIMULATION");
        $display("---------------------------------------");

        $display("Slave Address = %b", slave_addr);
        $display("Data to Send  = %h", data_in);

        #10;

        start = 1;

        #10;

        start = 0;

        wait(done);

        #20;

        $display("---------------------------------------");
        $display("Transmission Completed");
        $display("Received Data = %h", received_data);
        $display("Data Valid    = %b", data_valid);
        $display("---------------------------------------");

        $finish;

    end

endmodule