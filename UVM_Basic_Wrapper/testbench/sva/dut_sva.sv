module dut_sva(input logic clk,
               input logic rst_n,
               input logic [7:0] rxd,
               input logic rx_dv,
               input logic [7:0] txd,
               input logic tx_en);

// May need to check active-low reset
// property active_low_reset_functionality;
//    @(posedge clk) 
//    $fell(rst_n) |=> (txd == 8'h0 && tx_en == 0); // After reset falls, outputs are 0 next cycle
// endproperty

 
// property active_low_reset_hold;
//    @(posedge clk) 
//    !rst_n |=> (txd == 8'h0 && tx_en == 0); // While reset is low, outputs stay 0
// endproperty

property txd_gets_rxd;
    @(posedge clk) disable iff(!rst_n)
    rx_dv |=> tx_en && txd == $past(rxd, 1);
endproperty

// Reset_Func: assert property (active_low_reset_functionality);
// Reset_Hold: assert property (active_low_reset_hold);
txd_Gets_rxd: assert property (txd_gets_rxd);

endmodule

bind dut dut_sva dut_sva_check(.clk(clk),
                               .rst_n(rst_n),
                               .rxd(rxd),
                               .rx_dv(rx_dv),
                               .txd(txd),
                               .tx_en(tx_en));
