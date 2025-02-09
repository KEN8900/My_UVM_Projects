clear -all

analyze -sv09 ../sva/dut_sva.sv
analyze -sv09 ../../dut/dut.sv
elaborate -top dut

clock clk
reset ~rst_n
