`ifndef ENVIRONMENT__SV
`define ENVIRONMENT__SV

`include "agent_in.sv"
`include "agent_out.sv"
`include "ref_model.sv"
`include "scoreboard.sv"

class environment extends uvm_env;
    agent_in    agt_in;
    agent_out   agt_out;
    ref_model   mdl;
    scoreboard  scb;
    
    uvm_tlm_analysis_fifo #(transaction_out) agt_out_scb_fifo;
    uvm_tlm_analysis_fifo #(transaction_in)  agt_in_mdl_fifo;
    uvm_tlm_analysis_fifo #(transaction_out) mdl_scb_fifo;

    extern function new(string name, uvm_component parent);
    extern virtual function void build_phase(uvm_phase phase);  
    extern virtual function void connect_phase(uvm_phase phase);
    
    `uvm_component_utils(environment);
endclass

function environment::new(string name = "environment", uvm_component parent);
    super.new(name, parent);
endfunction

function void environment::build_phase(uvm_phase phase);
    super.build_phase(phase);
    agt_in   = agent_in::type_id::create("agt_in", this);
    agt_out  = agent_out::type_id::create("agt_out", this);
    // agt_in.is_active = UVM_ACTIVE;
    // agt_out.is_active = UVM_PASSIVE;
    mdl = ref_model::type_id::create("mdl", this);
    scb = scoreboard::type_id::create("scb", this);

    agt_out_scb_fifo = new("agt_out_scb_fifo", this);
    agt_in_mdl_fifo = new("agt_in_mdl_fifo", this);
    mdl_scb_fifo = new("mdl_scb_fifo", this);
endfunction
 
function void environment::connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    agt_out.ap.connect(agt_out_scb_fifo.analysis_export);
    scb.act_port.connect(agt_out_scb_fifo.blocking_get_export);

    agt_in.ap.connect(agt_in_mdl_fifo.analysis_export);
    mdl.port.connect(agt_in_mdl_fifo.blocking_get_export);

    mdl.ap.connect(mdl_scb_fifo.analysis_export);
    scb.exp_port.connect(mdl_scb_fifo.blocking_get_export);     
endfunction

`endif
