# A Simple Data Wrapper DUT

The folder `UVM_Data_Wrapper` contains a simple Data Wrapper as DUT. More details can be found in `Data_Wrapper_Module_Test_Plan_and_Results.pdf`.



## File Hierarchy

The files are organized into distinct folders.

- `dut`: Contains the RTL design file of the Data Wrapper.

- `testbench`: Contains all the files for different verification methods. Further categorized based on normal simulation testbench, Formal Property Verification (FPV), and UVM.

  - `testbench/sim_results`: Contains simulation testbench's results.

  - `testbench/sim_tb`: Contains simulation testbench.

  - `testbench/sim_tb_script`: Contains necessary scripts to control EDA.

  - `testbench/sva`: Contains SystemVerilog Properties for FPV.

  - `testbench/sva_results`: Contains FPV results.

  - `testbench/sva_script`: Contains necessary scripts to control EDA.

  - `testbench/uvm`: Contains components for UVM.

  - `testbench/uvm_results`: Contains UVM's results.

  - `testbench/uvm_script`: Contains necessary scripts to control EDA.