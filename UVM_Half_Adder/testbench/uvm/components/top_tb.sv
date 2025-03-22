`timescale 1ns/1ps

`include "uvm_macros.svh"
import uvm_pkg::*;

`include "agent_in.sv"
`include "agent_out.sv"
`include "base_test.sv"
`include "driver_in.sv"
`include "environment.sv"
`include "monitor_in.sv"
`include "monitor_out.sv"
`include "ref_model.sv"
`include "scoreboard.sv"
`include "sequencer.sv"
`include "transaction_in.sv"
`include "transaction_out.sv"
`include "virtual_sequencer.sv"
`include "interface.sv"
`include "base_sequence.sv"
`include "order_data_1delay_case.sv"
`include "order_data_burst_case.sv"
`include "order_data_random_delay_case.sv"
`include "random_data_1delay_case.sv"
`include "random_data_burst_case.sv"
`include "random_data_random_delay_case.sv"

module top_tb;

    logic clk;
    logic rst_n;

    interface_in    input_if(clk, rst_n);
    interface_out   output_if(clk, rst_n);

    half_adder dut_top(.clk(input_if.clk), 
                       .rst_n(input_if.rst_n), 
                       .data_in0(input_if.data0), 
                       .data_in1(input_if.data1), 
                       .in_valid(input_if.valid), 
                       .data_out(output_if.data), 
                       .out_valid(output_if.valid));

initial begin
    clk = 0;
    forever begin
        #100 clk <= ~clk;        // 5MHz
    end
end

initial begin
    rst_n <= 1'b0;
    #1000;
    rst_n <= 1'b1;
end

initial begin
    // set the format for time display
    $timeformat(-9, 2, "ns", 10);      
    // do interface configuration from top_tb (HW) to verification env (SW)
    uvm_config_db # (virtual interface_in )::set(null, "uvm_test_top.env.agt_in.drv_in",  "vif", input_if);
    uvm_config_db # (virtual interface_in )::set(null, "uvm_test_top.env.agt_in.mon_in",  "vif", input_if);
    uvm_config_db # (virtual interface_out)::set(null, "uvm_test_top.env.agt_out.mon_out", "vif", output_if);
end

initial begin
    run_test();
end

initial begin 
    string testname;
    if($value$plusargs("TESTNAME=%s", testname)) begin
        $fsdbDumpfile({testname, "_sim_dir/", testname, ".fsdb"});
    end 
    else begin
        $fsdbDumpfile("top_tb.fsdb");
    end
    $fsdbDumpvars(0, top_tb);
end

endmodule
