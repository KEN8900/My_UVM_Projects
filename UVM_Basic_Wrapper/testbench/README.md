# A Simple and Basic Data Wrapper DUT

The folder `UVM_Basic_Wrapper` contains a simple and basic Data Wrapper as DUT. More details can be find in `Wrapper_Module_Test_Plan_and_Results.pdf`.



## File Hierarchy

The files are organized into distinct folders.

- `dut`: Contains the RTL design file of the Data Wrapper.

- `testbench`: Contains all the files for different verification methods. Further categorized based on normal simulation testbench, formal property verification, and UVM.

  - `testbench/sim_results`: Contains simulation testbench's results.

  - `testbench/sim_tb`: Contains simulation testbench.

  - `testbench/sim_tb_script`: Contains necessary scripts to control EDA.

  - `testbench/sva`: Contains SystemVerilog Properties for formal property verification.

  - `testbench/sva_results`: Contains formal property verification's results.

  - `testbench/sva_script`: Contains expected scripts to control EDA (I do not have access now so just expected).

  - `testbench/uvm`: Contains components for UVM.

  - `testbench/uvm_results`: Contains UVM's results.

  - `testbench/uvm_script`: Contains necessary scripts to control EDA.

    