`ifndef ORDER_DATA_RANDOM_DELAY_CASE__SV
`define ORDER_DATA_RANDOM_DELAY_CASE__SV

`include "base_sequence.sv"

class order_data_random_delay_sequence extends uvm_sequence;
    `uvm_object_utils(order_data_random_delay_sequence);
    `uvm_declare_p_sequencer(virtual_sequencer);

    function new(string name = "order_data_random_delay_sequence");
        super.new(name);
    endfunction

    virtual task body();
        base_sequence dut_seq;

        if(starting_phase != null) begin
            starting_phase.raise_objection(this);
        end
        
        
        for(int add0=10; add0<30; add0++) begin
            for(int add1=0; add1<50; add1++) begin
                `uvm_do_on_with(dut_seq, p_sequencer.p_dut_sqr, {data0 == add0; data1 == add1; ntrans == 1; ndelay == -1;});
            end 
            #500;
        end

        #5000;
        
        if(starting_phase != null) begin
            starting_phase.drop_objection(this);
        end
    endtask    
endclass


class order_data_random_delay_case extends base_test;
    `uvm_component_utils(order_data_random_delay_case);

    function new(string name = "order_data_random_delay_case", uvm_component parent);
        super.new(name, parent);
    endfunction
    
    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        
        uvm_config_db #(uvm_object_wrapper)::set(this, 
                                                 "v_sqr.main_phase", 
                                                 "default_sequence", 
                                                 order_data_random_delay_sequence::type_id::get());
    
    endfunction
endclass

`endif