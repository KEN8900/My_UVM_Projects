import os

def create_vcf_script():
    vcf_script = """ 
    set_fml_appmode FPV
    set design dut

    set_app_var fml_mode_on true
    read_file -top $design -format sverilog -sva \
              -vcs {-full64 -sverilog -f filelist.f}
    #read_waiver_file -elfiles aep.el

    # Creating clock and reset signals
    create_clock clk -period 100 
    create_reset rst_n -sense low

    # Running a reset simulation
    sim_run -stable 
    sim_save_reset
    """
    
    with open("run_vcf.tcl", "w") as f:
        f.write(vcf_script)
    print("run_vcf.tcl created successfully.")

def run_vcf():
    if not os.path.exists("filelist.f"):
        print("Error: filelist.f not found. Ensure it exists in the current directory.")
        return
    
    if not os.path.exists("run_vcf.tcl"):
        print("Error: run_vcf.tcl not found. Creating it now.")
        create_vcf_script()
    
    os.system("vcf -verdi -f run_vcf.tcl > script_gen.log") # like Makefile
    
    if os.path.exists("script_gen.log"):
        print("VCF completed successfully. Check script_gen.log for details.")
    else:
        print("Error: script_gen.log was not created. Check the VCF execution output.")

if __name__ == "__main__":
    # print("Current Working Directory:", os.getcwd())
    # print("Files in Directory:", os.listdir())
    create_vcf_script()
    run_vcf()
