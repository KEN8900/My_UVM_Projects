`ifndef DRIVER_IN__SV
`define DRIVER_IN__SV

`include "transaction_in.sv"

class driver_in extends uvm_driver#(transaction_in);

    virtual interface_in vif;

    extern function new(string name, uvm_component parent);
    extern virtual function void build_phase(uvm_phase phase);
    extern virtual task main_phase(uvm_phase phase);
    extern virtual task drive_one_pkt(transaction_in tr);

    `uvm_component_utils(driver_in)
endclass

function driver_in::new(string name = "driver_in", uvm_component parent);
    super.new(name, parent);
endfunction

function void driver_in::build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db#(virtual interface_in)::get(this, "", "vif", vif)) begin
        `uvm_fatal("driver_in", "virtual interface_in must be set for vif!!!")
    end
endfunction

task driver_in::main_phase(uvm_phase phase);
    vif.data0 <= 8'b0;
    vif.data1 <= 8'b0;
    vif.valid <= 1'b0;
    while(!vif.rst_n) begin
        @(posedge vif.clk);
    end
    while(1) begin
        seq_item_port.get_next_item(req);
        drive_one_pkt(req);
        seq_item_port.item_done();
    end
endtask
 
task driver_in::drive_one_pkt(transaction_in tr);

    `uvm_info("driver_in", "begin to drive one pkt", UVM_LOW);

    @(vif.drv_ck);
    vif.drv_ck.data1 <= tr.data1;
    vif.drv_ck.data0 <= tr.data0;
    vif.drv_ck.valid <= 1'b1;
    @(posedge vif.clk);
    vif.drv_ck.valid <= 1'b0;
    repeat(tr.ndelay) @(posedge vif.clk);
    // repeat(tr.ndelay) @(vif.drv_ck);

    `uvm_info("driver_in", "end drive one pkt", UVM_LOW);
endtask

`endif
