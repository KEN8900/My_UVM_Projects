`ifndef BASE_TEST__SV
`define BASE_TEST__SV

`include "environment.sv"
`include "virtual_sequencer.sv"

class base_test extends uvm_test;
    environment env;
    virtual_sequencer v_sqr;

    extern function new(string name, uvm_component parent);
    extern virtual function void build_phase(uvm_phase phase);
    extern virtual function void connect_phase(uvm_phase phase);
    extern virtual function void report_phase(uvm_phase phase);

    `uvm_component_utils(base_test)
endclass

function base_test::new(string name = "base_test", uvm_component parent);
    super.new(name, parent);
endfunction

function void base_test::build_phase(uvm_phase phase);
    super.build_phase(phase);
    env = environment::type_id::create("env", this);
    v_sqr = virtual_sequencer::type_id::create("v_sqr", this);
endfunction

function void base_test::connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    v_sqr.p_dut_sqr = env.agt_in.sqr;
    // if(get_report_verbosity_level() >= UVM_HIGH ) begin 
    //     uvm_top.print_topology();
    // end
endfunction

function void base_test::report_phase(uvm_phase phase);
    uvm_report_server server;
    integer fid;
    int err_num;
    string testname;
    $value$plusargs("TESTNAME=%s", testname);
    super.report_phase(phase);

    server = get_report_server();
    err_num =  server.get_severity_count(UVM_WARNING) + server.get_severity_count(UVM_ERROR) + server.get_severity_count(UVM_FATAL);

    $system("date +[%F/%T] >> result_sim.log");
    fid = $fopen("result_sim.log","a");
    $display("");

    if( err_num != 0 ) begin
        $display("==================================================");
        $display("%s TestCase Failed !!!", testname);
        $display("It has %0d error(s).", err_num);
        $display("!!!!!!!!!!!!!!!!!!");
        $fwrite( fid, $sformatf("TestCase Failed: %s\n\n", testname) );
    end else begin
        $display("==================================================");
        $display("TestCase Passed: %s", testname);
        $display("==================================================");
        $fwrite( fid, $sformatf("TestCase Passed: %s\n\n", testname) );
    end
endfunction

`endif 


 
