UVM_HOME = /home/ken/Synopsys/uvm-1.1d
SINGLE_TEST ?= random_data_random_delay_case
#-------------------------------------------------------------------------------------------------------
do_all_serial: clean all_serial
#-------------------------------------------------------------------------------------------------------
# do_all_parallel: clean all_parallel # Still have some issues
#-------------------------------------------------------------------------------------------------------
do_single: clean single
#-------------------------------------------------------------------------------------------------------
all_serial:
	sh run_all_tests_serial.sh
#-------------------------------------------------------------------------------------------------------
# Still have some issues
# all_parallel:
#	 sh run_all_tests_parallel.sh
#-------------------------------------------------------------------------------------------------------
single:
	vcs  \
        -fsdb -full64 -R +vc +v2k -sverilog -debug_all \
        -l ${SINGLE_TEST}.log \
        -timescale=1ns/1ps \
        -cpp g++ -cc gcc -LDFLAGS -Wl,--no-as-needed \
        +acc +vpi \
        +define+UVM_OBJECT_MUST_HAVE_CONSTRUCTOR \
        +incdir+${UVM_HOME}/src \
        ${UVM_HOME}/src/uvm.sv \
        ${UVM_HOME}/src/dpi/uvm_dpi.cc -CFLAGS -DVCS \
        +UVM_TESTNAME=${SINGLE_TEST} \
        -f filelist.f
#-------------------------------------------------------------------------------------------------------
gui:
	./simv -gui
#-------------------------------------------------------------------------------------------------------
sim:
	./simv -l simv.log
#-------------------------------------------------------------------------------------------------------
verdi:
	verdi -f filelist.f -ssf top_tb.fsdb
#-------------------------------------------------------------------------------------------------------
clean:
	rm  -rf  *~  core  csrc  simv*  vc_hdrs.h  ucli.key  urg* *.log  novas.* *.fsdb* verdiLog  64* DVEfiles 
	rm  -rf *.vpd *.inter.vpd.uvm* *.uvm *.lock

