UVM_HOME = /home/ken/Synopsys/uvm-1.1d
#-------------------------------------------------------------------------------------------------------
comp  : clean vcs gui
#-------------------------------------------------------------------------------------------------------
vcs   :
	vcs  \
	      	-fsdb -full64  -R  +vc  +v2k  -sverilog  -debug_all \
	      	-l vcs.log \
			-timescale=1ns/1ps \
			-cpp g++-4.8 -cc gcc-4.8 -LDFLAGS -Wl,--no-as-needed \
			+acc +vpi \
			+define+UVM_OBJECT_MUST_HAVE_CONSTRUCTOR \
			+incdir+$(UVM_HOME)/src \
			$(UVM_HOME)/src/uvm.sv \
			$(UVM_HOME)/src/dpi/uvm_dpi.cc -CFLAGS -DVCS \
			+UVM_TESTNAME=my_case1 \
			-f filelist.f

#-------------------------------------------------------------------------------------------------------
gui    :
	./simv -gui
#-------------------------------------------------------------------------------------------------------
sim    :
	./simv -l simv.log
#-------------------------------------------------------------------------------------------------------
verdi  :
	verdi -f filelist.f -ssf top_tb.fsdb
#-------------------------------------------------------------------------------------------------------
clean  :
	 rm  -rf  *~  core  csrc  simv*  vc_hdrs.h  ucli.key  urg* *.log  novas.* *.fsdb* verdiLog  64* DVEfiles 
	 rm  -rf *.vpd *.inter.vpd.uvm* *.uvm

