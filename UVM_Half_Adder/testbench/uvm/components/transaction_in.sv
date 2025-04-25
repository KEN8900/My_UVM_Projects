`ifndef TRANSACTION_IN__SV
`define TRANSACTION_IN__SV

class transaction_in extends uvm_sequence_item;
    rand bit[8:0] data0;
    rand bit[8:0] data1;
    rand int      ndelay;

    constraint data_cstr{
        data0 inside {[0:255]};
        data1 inside {[0:255]};
        ndelay inside {[0:50]};
    }

    `uvm_object_utils_begin(transaction_in)
        `uvm_field_int(data0, UVM_ALL_ON);
        `uvm_field_int(data1, UVM_ALL_ON);
    `uvm_object_utils_end

    extern function new(string name);
endclass

function transaction_in::new(string name = "transaction_in");
    super.new(name);
endfunction

`endif
