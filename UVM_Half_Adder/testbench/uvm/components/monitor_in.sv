`ifndef MONITOR_IN__SV
`define MONITOR_IN__SV

`include "transaction_in.sv"

class monitor_in extends uvm_monitor;

    virtual interface_in vif;
 
    uvm_analysis_port #(transaction_in)  ap;

    extern function new(string name, uvm_component parent);
    extern virtual function void build_phase(uvm_phase phase); 
    extern virtual task main_phase(uvm_phase phase);
    extern virtual task collect_one_pkt(transaction_in tr);

    `uvm_component_utils(monitor_in);
endclass

function monitor_in::new(string name = "monitor_in", uvm_component parent);
    super.new(name, parent);
endfunction

function void monitor_in::build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db#(virtual interface_in)::get(this, "", "vif", vif)) begin
        `uvm_fatal("monitor_in", "virtual interface_in must be set for vif!!!");
    end
    
    ap = new("ap", this);
endfunction
 
task monitor_in::main_phase(uvm_phase phase);
    transaction_in tr;
    while(1) begin
       tr = new("tr_in_from_driver_in");
       collect_one_pkt(tr);
       ap.write(tr);
    end
endtask
 
task monitor_in::collect_one_pkt(transaction_in tr);
    
    @(posedge vif.clk iff(vif.valid));
    `uvm_info("monitor_in", "begin to collect one pkt", UVM_LOW);

    tr.data0 = vif.data0;
    tr.data1 = vif.data1;
    `uvm_info("monitor_in", $sformatf("collect one pkt: \n%s", tr.sprint()), UVM_LOW);

endtask

`endif
