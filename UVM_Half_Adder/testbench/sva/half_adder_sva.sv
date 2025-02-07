module half_adder_sva(input logic clk,
                      input logic rst_n,
                      input logic [8:0] data_in0,
                      input logic [8:0] data_in1
                      input logic in_valid,
                      input logic [9:0] data_out,
                      input logic out_valid);

// May need to check active-low reset
// property active_low_reset_functionality;
//   @(posedge clk) 
//   $fell(rst_n) |=> (data_out == 9'h0 && out_valid == 0); // After reset falls, outputs are 0 next cycle
// endproperty

// property active_low_reset_hold;
//   @(posedge clk) 
//   !rst_n |=> (data_out == 9'h0 && out_valid == 0); // While reset is low, outputs stay 0
// endproperty

property correct_data_out;
    @(posedge clk) disable iff(!rst_n)
    in_valid |=> out_valid && (data_out == $past(data_in0, 1) + $past(data_in1, 1));
endproperty

Correct_data_out: assert property (correct_data_out);

endmodule

bind half_adder half_adder_sva half_adder_sva_check(.clk(clk),
                                                    .rst_n(rst_n),
                                                    .data_in0(data_in0),
                                                    .data_in1(data_in1),
                                                    .in_valid(in_valid),
                                                    .data_out(data_out),
                                                    .out_valid(out_valid));
