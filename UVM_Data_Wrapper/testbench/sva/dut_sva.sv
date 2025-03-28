module dut_sva(input logic clk,
               input logic rst_n,
               input logic [7:0] rxd,
               input logic rx_dv,
               input logic [7:0] txd,
               input logic tx_en);

//--------------------------------------------------------------------------------------
// May need to check active-low reset
property active_low_reset_functionality;
   @(posedge clk) 
   $rose(rst_n) |-> (txd == 8'h0 && tx_en == 0);
endproperty

// property active_low_reset_hold;
//    @(posedge clk) 
//    !rst_n |-> (txd == 8'h0 && tx_en == 0); // While reset is low, outputs stay 0
// endproperty

//--------------------------------------------------------------------------------------
property check_signal_and_data_1;
    @(posedge clk) disable iff(!rst_n)
    !rx_dv |=> !tx_en && txd == $past(rxd);
endproperty

property check_signal_and_data_2;
    @(posedge clk) disable iff(!rst_n)
    rx_dv |=> tx_en && txd == $past(rxd);
endproperty

//--------------------------------------------------------------------------------------
Active_low_reset_functionality: assert property (active_low_reset_functionality);
// Active_low_reset_hold: assert property (active_low_reset_hold);

//--------------------------------------------------------------------------------------
Check_signal_and_data_1: assert property (check_signal_and_data_1);
Check_signal_and_data_2: assert property (check_signal_and_data_2);

endmodule

bind dut dut_sva dut_sva_check(.clk(clk),
                               .rst_n(rst_n),
                               .rxd(rxd),
                               .rx_dv(rx_dv),
                               .txd(txd),
                               .tx_en(tx_en));
