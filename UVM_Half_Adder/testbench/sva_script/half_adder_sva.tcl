clear -all

analyze -sv09 ../sva/half_adder_sva.sv
analyze -sv09 ../../dut/half_adder.sv
elaborate -top half_adder

clock clk
reset ~rst_n
