set_fml_appmode FPV
set design half_adder

set_app_var fml_mode_on true
read_file -top $design -format sverilog -sva \
          -vcs {-full64 -sverilog -f filelist.f}
#read_waiver_file -elfiles aep.el

# Creating clock and reset signals
create_clock clk -period 100 
create_reset rst_n -sense low

# Runing a reset simulation
sim_run -stable 
sim_save_reset