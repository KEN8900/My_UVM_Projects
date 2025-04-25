`ifndef SCOREBOARD__SV
`define SCOREBOARD__SV

class scoreboard extends uvm_scoreboard;
    transaction_out  expect_queue[$];

    uvm_blocking_get_port #(transaction_out)  exp_port;
    uvm_blocking_get_port #(transaction_out)  act_port;
    
    extern function new(string name, uvm_component parent);
    extern virtual function void build_phase(uvm_phase phase);
    extern virtual task main_phase(uvm_phase phase);

    `uvm_component_utils(scoreboard);
endclass 
 
function scoreboard::new(string name = "scoreboard", uvm_component parent);
    super.new(name, parent);
endfunction 
 
function void scoreboard::build_phase(uvm_phase phase);
    super.build_phase(phase);
    exp_port = new("exp_port", this);
    act_port = new("act_port", this);
endfunction 
 
task scoreboard::main_phase(uvm_phase phase);
    transaction_out get_expect, get_actual, tmp_tran;
    bit result;
  
    super.main_phase(phase);
    fork 
        while (1) begin
            exp_port.get(get_expect);
            expect_queue.push_back(get_expect);
        end
        while (1) begin
            act_port.get(get_actual);
            if(expect_queue.size() > 0) begin
                tmp_tran = expect_queue.pop_front();
                result = get_actual.compare(tmp_tran);
                if (result) begin 
                    `uvm_info("scoreboard", "Compare SUCCESSFULLY", UVM_LOW);
                end
                else begin
                    `uvm_error("scoreboard", "Compare FAILED");
                    $display("the expect pkt is");
                    tmp_tran.print();
                    $display("the actual pkt is");
                    get_actual.print();
                end
            end
            else begin
                `uvm_error("scoreboard", "Received from DUT, while Expect Queue is empty");
                $display("the unexpected pkt is");
                get_actual.print();
            end 
        end
    join
endtask

`endif