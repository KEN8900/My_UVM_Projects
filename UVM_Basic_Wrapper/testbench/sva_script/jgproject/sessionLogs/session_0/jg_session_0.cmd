# ----------------------------------------
# Jasper Version Info
# tool      : Jasper 2024.06
# platform  : Linux 4.18.0-553.34.1.el8_10.x86_64
# version   : 2024.06p002 64 bits
# build date: 2024.09.02 16:28:38 UTC
# ----------------------------------------
# started   : 2025-02-08 21:17:02 EST
# hostname  : micro29.(none)
# pid       : 2183476
# arguments : '-label' 'session_0' '-console' '//127.0.0.1:37095' '-style' 'windows' '-data' 'AAAAfnicY2RgYLCp////PwMYMD6A0Aw2jAyoAMRnQhUJbEChGRhYYZqRNYkxpDCUMpQwxDMUM5QxJDLoAdnJDDlgeQDwsgs+' '-proj' '/homes/user/stud/fall23/hy2819/GitHub_Codes/My_UVM_Projects/UVM_Basic_Wrapper/testbench/sva_script/jgproject/sessionLogs/session_0' '-init' '-hidden' '/homes/user/stud/fall23/hy2819/GitHub_Codes/My_UVM_Projects/UVM_Basic_Wrapper/testbench/sva_script/jgproject/.tmp/.initCmds.tcl' 'dut_sva.tcl'
clear -all

analyze -sv09 ../sva/dut_sva.sv
analyze -sv09 ../../dut/dut.sv
elaborate -top dut

clock clk
reset ~rst_n
prove -bg -all
