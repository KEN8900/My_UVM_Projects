`timescale 1ns/1ns

module testbench();
	reg clk;
    reg rst_n;
	reg [8:0] data_in0;
    reg [8:0] data_in1;
	reg in_valid;
    wire [9:0] data_out;
    wire out_valid;

    // Create clock with period = 10 ns
	always begin
        #5 clk = ~clk;
    end  
	//initial `probe_start;   // Start the timing diagram
        
	initial begin
		clk = 1;
        rst_n = 0;

        #11;
        rst_n = 1;
    end

    initial begin
        in_valid <= 1'b0;
        data_in0 <= 9'd0;
        data_in1 <= 9'd0;
        
        wait(!rst_n);
        wait(rst_n);

        @(posedge clk);
        in_valid <= 1'b1;
        data_in0 <= 9'd10;
        data_in1 <= 9'd61;
        
        #10;
        data_in0 <= 9'd50;
        data_in1 <= 9'd11;
        
        #10;
        in_valid <= 1'b0;
        data_in0 <= 9'd26;
        data_in1 <= 9'd30;

        #10;
        data_in0 <= 9'd3;
        data_in1 <= 9'd12;

        #20;
        $finish;
	end
	
	//Sub-modules
    half_adder half_adder_0(.clk(clk),
                            .rst_n(rst_n),
                            .data_in0(data_in0),
                            .data_in1(data_in1),
                            .in_valid(in_valid),
                            .data_out(data_out),
                            .out_valid(out_valid));
	
//	initial begin
//	   $dumpfile("tb.vcd");
//	    This will dump all signal, which may not be useful
//	   $dumpvars;
//	    dumping only this module
//	   $dumpvars(1, testbench);
//	    dumping only these variable
//	    the first number (level) is actually useless
//	   $dumpvars(0, testbench);
//	end  

	// initial	begin
	// 	    $fsdbDumpfile("tb.fsdb"); // .fsdb file for verdi
	// 	    $fsdbDumpvars;
	// end
    
endmodule
