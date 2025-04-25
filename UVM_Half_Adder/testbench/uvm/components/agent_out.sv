`ifndef AGENT_OUT__SV
`define AGENT_OUT__SV

`include "monitor_out.sv"

class agent_out extends uvm_agent;
    monitor_out  mon_out;
    
    uvm_analysis_port #(transaction_out)  ap;
    
    extern function new(string name, uvm_component parent);
    extern virtual function void build_phase(uvm_phase phase);
    extern virtual function void connect_phase(uvm_phase phase);

    `uvm_component_utils(agent_out); 
endclass 
 
function agent_out::new(string name = "agent_out", uvm_component parent);
    super.new(name, parent);
endfunction 
 
function void agent_out::build_phase(uvm_phase phase);
    super.build_phase(phase);
    mon_out = monitor_out::type_id::create("mon_out", this);
endfunction 
 
function void agent_out::connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    ap = mon_out.ap;
endfunction

`endif
