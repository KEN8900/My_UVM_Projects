`ifndef BASE_SEQUENCE__SV
`define BASE_SEQUENCE__SV

class base_sequence extends uvm_sequence #(transaction_in);
    randc int data0 = -1;
    randc int data1 = -1; 
    randc int ndelay = -1;
    randc int ntrans = 10;

    constraint data_cstr{
        soft data0 == -1;
        soft data1 == -1;
        soft ndelay == 1;
        soft ntrans inside {[5:50]};
    }

    extern function new(string name);
    extern virtual task body();

    `uvm_object_utils(base_sequence);
endclass

function base_sequence::new(string name = "base_sequence");
    super.new(name);
endfunction

task base_sequence::body();
    `uvm_info("base_sequence",  $sformatf("send %0d transaction to sequencer", ntrans), UVM_LOW);
    // req is implicit declared, like:
    // transaction_in req
    repeat(ntrans) begin
        `uvm_do_with(req, {local::data0 >= 0 -> data0 == local::data0;
                           local::data1 >= 0 -> data1 == local::data1;
                           local::ndelay >= 0 -> ndelay == local::ndelay;})
    end
endtask

`endif
