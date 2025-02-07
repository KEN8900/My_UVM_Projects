`ifndef SEQUENCER__SV
`define SEQUENCER__SV

`include "transaction_in.sv"

class sequencer extends uvm_sequencer #(transaction_in);
   
    extern function new(string name, uvm_component parent);

    `uvm_component_utils(sequencer)
endclass

function sequencer::new(string name = "sequencer", uvm_component parent);
    super.new(name, parent);
endfunction

`endif
