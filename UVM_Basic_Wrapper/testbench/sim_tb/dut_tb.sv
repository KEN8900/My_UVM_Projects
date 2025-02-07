`timescale 1ns/1ns

module testbench();
	reg clk;
    reg rst_n;
	reg [7:0] rxd;
	reg rx_dv;
    wire [7:0] txd;
    wire tx_en;

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
        rxd <= 8'd100;
        rx_dv <= 1'b0;

        wait(!rst_n);
        wait(rst_n);

        @(posedge clk);
        rxd <= 8'd110;
        rx_dv <= 1'b1;
        
        #10;
        rxd <= 8'd120;
        rx_dv <= 1'b0;
        
        #10;
        rxd <= 8'd130;
        rx_dv <= 1'b1;

        #20;
        $finish;
	end
	
	//Sub-modules
    dut dut_0(.clk(clk),
              .rst_n(rst_n),
              .rxd(rxd),
              .rx_dv(rx_dv),
              .txd(txd),
              .tx_en(tx_en));
	
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

	initial	begin
		    $fsdbDumpfile("tb.fsdb"); // .fsdb file for verdi
		    $fsdbDumpvars;
	end
    
endmodule
