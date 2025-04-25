#!/bin/bash

TESTS=(
    order_data_1delay_case
    order_data_burst_case
    order_data_random_delay_case
    random_data_1delay_case
    random_data_burst_case
    random_data_random_delay_case
)

for TEST in "${TESTS[@]}"
do
    echo "============================================"
    echo "Running test sequence: $TEST"
    
    vcs  \
        -fsdb -full64 -R +vc +v2k -sverilog -debug_all \
        -l ${TEST}.log \
        -timescale=1ns/1ps \
        -cpp g++ -cc gcc -LDFLAGS -Wl,--no-as-needed \
        +acc +vpi \
        +define+UVM_OBJECT_MUST_HAVE_CONSTRUCTOR \
        +incdir+${UVM_HOME}/src \
        ${UVM_HOME}/src/uvm.sv \
        ${UVM_HOME}/src/dpi/uvm_dpi.cc -CFLAGS -DVCS \
        +UVM_TESTNAME=${TEST} \
        -f filelist.f

    echo ""
done

echo "======== FINAL SUMMARY ========="
cat result_sim.log

