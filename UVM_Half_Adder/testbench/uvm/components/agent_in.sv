`ifndef AGENT_IN__SV
`define AGENT_IN__SV

`include "sequencer.sv"
`include "driver_in.sv"
`include "monitor_in.sv"

class agent_in extends uvm_agent;
    sequencer    sqr;
    driver_in    drv_in;
    monitor_in   mon_in;
    
    uvm_analysis_port #(transaction_in)  ap;
    
    extern function new(string name, uvm_component parent);
    extern virtual function void build_phase(uvm_phase phase);
    extern virtual function void connect_phase(uvm_phase phase);
 
    `uvm_component_utils(agent_in)
endclass 
 
function agent_in::new(string name = "agent_in", uvm_component parent);
       super.new(name, parent);
endfunction 

function void agent_in::build_phase(uvm_phase phase);
    super.build_phase(phase);
    sqr = sequencer::type_id::create("sqr", this);
    drv_in = driver_in::type_id::create("drv_in", this);
    mon_in = monitor_in::type_id::create("mon_in", this);
endfunction 
 
function void agent_in::connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    drv_in.seq_item_port.connect(sqr.seq_item_export);
    ap = mon_in.ap;
endfunction

`endif