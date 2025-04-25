`ifndef REF_MODEL__SV
`define REF_MODEL__SV

class ref_model extends uvm_component;
   
    uvm_blocking_get_port #(transaction_in)  port;
    uvm_analysis_port #(transaction_out)  ap;
 
    extern function new(string name, uvm_component parent);
    extern virtual function void build_phase(uvm_phase phase);
    extern virtual task main_phase(uvm_phase phase);
 
    `uvm_component_utils(ref_model);
endclass 
 
function ref_model::new(string name = "ref_model", uvm_component parent);
    super.new(name, parent);
endfunction 
 
function void ref_model::build_phase(uvm_phase phase);
    super.build_phase(phase);
    port = new("port", this);
    ap = new("ap", this);
endfunction
 
task ref_model::main_phase(uvm_phase phase);
    transaction_in tr;
    transaction_out new_tr;
    super.main_phase(phase);
    while(1) begin
        port.get(tr);
        new_tr = new("tr_from_ref_model");
        new_tr.data = tr.data0 + tr.data1;
        `uvm_info("ref_model", "get one transaction, do the addition and print it:", UVM_LOW);
        new_tr.print();
        ap.write(new_tr);
    end
endtask

`endif
