`ifndef VIRTUAL_SEQUENCER__SV
`define VIRTUAL_SEQUENCER__SV

`include "sequencer.sv"

class virtual_sequencer extends uvm_sequencer;
    sequencer p_dut_sqr;

	extern function new(string name, uvm_component parent);

	`uvm_component_utils(virtual_sequencer)
endclass

function virtual_sequencer::new(string name = "virtual_sequencer", uvm_component parent);
    super.new(name, parent);
endfunction

`endif
