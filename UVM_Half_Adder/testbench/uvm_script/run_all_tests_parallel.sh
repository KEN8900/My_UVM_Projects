#!/bin/bash

RESULT_LOG=result_sim.log
TESTS=(
    order_data_1delay_case
    order_data_burst_case
    order_data_random_delay_case
    random_data_1delay_case
    random_data_burst_case
    random_data_random_delay_case
)

# Clear the shared result log first
> $RESULT_LOG
rm -f result_sim.lock

# Function to compile, run, and safely log results
run_test() {
    TEST=$1
    TEST_DIR=run_$TEST
    mkdir -p $TEST_DIR

    echo "==> Running $TEST"

    vcs \
        -full64 -R +v2k -sverilog -debug_all \
        -l ${TEST_DIR}/${TEST}.log \
        -timescale=1ns/1ps \
        -cpp g++ -cc gcc -LDFLAGS -Wl,--no-as-needed \
        +acc +vpi \
        +define+UVM_OBJECT_MUST_HAVE_CONSTRUCTOR \
        +incdir+${UVM_HOME}/src \
        ${UVM_HOME}/src/uvm.sv \
        ${UVM_HOME}/src/dpi/uvm_dpi.cc -CFLAGS -DVCS \
        -f filelist.f \
        +UVM_TESTNAME=${TEST} \
        -o ${TEST_DIR}/simv_${TEST}

    if [[ -f ${TEST_DIR}/simv_${TEST} ]]; then
        ./${TEST_DIR}/simv_${TEST}
    else
        echo "ERROR: Build failed for $TEST"
    fi

    {
        flock 200
        echo "[`date '+%F %T'`] $TEST:" >> result_sim.log
        grep "TestCase" ${TEST_DIR}/${TEST}.log >> result_sim.log
        echo "" >> result_sim.log
    } 200>result_sim.lock
}


export -f run_test

# Run tests in parallel
for TEST in "${TESTS[@]}"; do
    run_test "$TEST" &
done

wait

echo "========= FINAL SUMMARY ========="
cat ${RESULT_LOG}
