# Half Adder DUT

The folder `UVM_Half_Adder` contains a Half Adder as DUT. More details can be found in `Half_Adder_Module_Test_Plan_and_Results.pdf`.



## File Hierarchy

The files are organized into distinct folders.

- `dut`: Contains the RTL design file of the Half Adder.
- `testbench`: Contains all the files for different verification methods. Further categorized based on normal simulation testbench, Formal Property Verification (FPV), and UVM.

  - `testbench/sim_results`: Contains simulation testbench's results.
  - `testbench/sim_tb`: Contains simulation testbench.
  - `testbench/sim_tb_script`: Contains necessary scripts to control EDA.
  - `testbench/sva`: Contains SystemVerilog Properties for FPV.
  - `testbench/sva_results`: Contains FPV results.
  - `testbench/sva_script`: Contains necessary scripts to control EDA.
  - `testbench/uvm`: Contains different UVM parts.

    - `testbench/uvm/components`: Contains components of UVM.

    - `testbench/uvm/interfaces`: Contains interfaces used in UVM.

    - `testbench/uvm/test_cases`: Contains different test cases used in UVM.
  - `testbench/uvm_results`: Contains UVM's results.
  - `testbench/uvm_script`: Contains necessary scripts to control EDA.