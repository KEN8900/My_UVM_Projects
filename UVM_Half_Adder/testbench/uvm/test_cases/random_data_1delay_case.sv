`ifndef RANDOM_DATA_1DELAY_CASE__SV
`define RANDOM_DATA_1DELAY_CASE__SV

`include "base_sequence.sv"

class random_data_1delay_sequence extends uvm_sequence;
    `uvm_object_utils(random_data_1delay_sequence)
    `uvm_declare_p_sequencer(virtual_sequencer)

    function new(string name = "random_data_1delay_sequence");
        super.new(name);
    endfunction

    virtual task body();
        base_sequence dut_seq;

        if(starting_phase != null) begin
            starting_phase.raise_objection(this);
        end
        
        // ndelay = 1 by soft constraint in base_sequence
        `uvm_do_on_with(dut_seq, p_sequencer.p_dut_sqr, {ntrans == 10;}) 

        #800;

        `uvm_do_on_with(dut_seq, p_sequencer.p_dut_sqr, {ntrans == 10;})

        #5000;
        
        if(starting_phase != null) begin
            starting_phase.drop_objection(this);
        end
    endtask    
endclass


class random_data_1delay_case extends base_test;
    `uvm_component_utils(random_data_1delay_case)

    function new(string name = "random_data_1delay_case", uvm_component parent);
        super.new(name, parent);
    endfunction
    
    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        
        uvm_config_db #(uvm_object_wrapper)::set(this, 
                                                 "v_sqr.main_phase", 
                                                 "default_sequence", 
                                                 random_data_1delay_sequence::type_id::get());
    
    endfunction
endclass

`endif