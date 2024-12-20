transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/nawaz/OneDrive/Desktop/programing/verilog/eyantra\ task\ 1/t1c_riscv_cpu/risc-V/code {C:/Users/nawaz/OneDrive/Desktop/programing/verilog/eyantra task 1/t1c_riscv_cpu/risc-V/code/t1c_riscv_cpu.v}
vlog -vlog01compat -work work +incdir+C:/Users/nawaz/OneDrive/Desktop/programing/verilog/eyantra\ task\ 1/t1c_riscv_cpu/risc-V/code {C:/Users/nawaz/OneDrive/Desktop/programing/verilog/eyantra task 1/t1c_riscv_cpu/risc-V/code/riscv_cpu.v}
vlog -vlog01compat -work work +incdir+C:/Users/nawaz/OneDrive/Desktop/programing/verilog/eyantra\ task\ 1/t1c_riscv_cpu/risc-V/code {C:/Users/nawaz/OneDrive/Desktop/programing/verilog/eyantra task 1/t1c_riscv_cpu/risc-V/code/data_mem.v}
vlog -vlog01compat -work work +incdir+C:/Users/nawaz/OneDrive/Desktop/programing/verilog/eyantra\ task\ 1/t1c_riscv_cpu/risc-V/code/components {C:/Users/nawaz/OneDrive/Desktop/programing/verilog/eyantra task 1/t1c_riscv_cpu/risc-V/code/components/reset_ff.v}
vlog -vlog01compat -work work +incdir+C:/Users/nawaz/OneDrive/Desktop/programing/verilog/eyantra\ task\ 1/t1c_riscv_cpu/risc-V/code/components {C:/Users/nawaz/OneDrive/Desktop/programing/verilog/eyantra task 1/t1c_riscv_cpu/risc-V/code/components/reg_file.v}
vlog -vlog01compat -work work +incdir+C:/Users/nawaz/OneDrive/Desktop/programing/verilog/eyantra\ task\ 1/t1c_riscv_cpu/risc-V/code/components {C:/Users/nawaz/OneDrive/Desktop/programing/verilog/eyantra task 1/t1c_riscv_cpu/risc-V/code/components/mux4.v}
vlog -vlog01compat -work work +incdir+C:/Users/nawaz/OneDrive/Desktop/programing/verilog/eyantra\ task\ 1/t1c_riscv_cpu/risc-V/code/components {C:/Users/nawaz/OneDrive/Desktop/programing/verilog/eyantra task 1/t1c_riscv_cpu/risc-V/code/components/mux3.v}
vlog -vlog01compat -work work +incdir+C:/Users/nawaz/OneDrive/Desktop/programing/verilog/eyantra\ task\ 1/t1c_riscv_cpu/risc-V/code/components {C:/Users/nawaz/OneDrive/Desktop/programing/verilog/eyantra task 1/t1c_riscv_cpu/risc-V/code/components/mux2.v}
vlog -vlog01compat -work work +incdir+C:/Users/nawaz/OneDrive/Desktop/programing/verilog/eyantra\ task\ 1/t1c_riscv_cpu/risc-V/code/components {C:/Users/nawaz/OneDrive/Desktop/programing/verilog/eyantra task 1/t1c_riscv_cpu/risc-V/code/components/main_decoder.v}
vlog -vlog01compat -work work +incdir+C:/Users/nawaz/OneDrive/Desktop/programing/verilog/eyantra\ task\ 1/t1c_riscv_cpu/risc-V/code/components {C:/Users/nawaz/OneDrive/Desktop/programing/verilog/eyantra task 1/t1c_riscv_cpu/risc-V/code/components/imm_extend.v}
vlog -vlog01compat -work work +incdir+C:/Users/nawaz/OneDrive/Desktop/programing/verilog/eyantra\ task\ 1/t1c_riscv_cpu/risc-V/code/components {C:/Users/nawaz/OneDrive/Desktop/programing/verilog/eyantra task 1/t1c_riscv_cpu/risc-V/code/components/datapath.v}
vlog -vlog01compat -work work +incdir+C:/Users/nawaz/OneDrive/Desktop/programing/verilog/eyantra\ task\ 1/t1c_riscv_cpu/risc-V/code/components {C:/Users/nawaz/OneDrive/Desktop/programing/verilog/eyantra task 1/t1c_riscv_cpu/risc-V/code/components/controller.v}
vlog -vlog01compat -work work +incdir+C:/Users/nawaz/OneDrive/Desktop/programing/verilog/eyantra\ task\ 1/t1c_riscv_cpu/risc-V/code/components {C:/Users/nawaz/OneDrive/Desktop/programing/verilog/eyantra task 1/t1c_riscv_cpu/risc-V/code/components/alu_decoder.v}
vlog -vlog01compat -work work +incdir+C:/Users/nawaz/OneDrive/Desktop/programing/verilog/eyantra\ task\ 1/t1c_riscv_cpu/risc-V/code/components {C:/Users/nawaz/OneDrive/Desktop/programing/verilog/eyantra task 1/t1c_riscv_cpu/risc-V/code/components/alu.v}
vlog -vlog01compat -work work +incdir+C:/Users/nawaz/OneDrive/Desktop/programing/verilog/eyantra\ task\ 1/t1c_riscv_cpu/risc-V/code/components {C:/Users/nawaz/OneDrive/Desktop/programing/verilog/eyantra task 1/t1c_riscv_cpu/risc-V/code/components/adder.v}
vlog -vlog01compat -work work +incdir+C:/Users/nawaz/OneDrive/Desktop/programing/verilog/eyantra\ task\ 1/t1c_riscv_cpu/risc-V/code/components {C:/Users/nawaz/OneDrive/Desktop/programing/verilog/eyantra task 1/t1c_riscv_cpu/risc-V/code/components/PCSrc_Decoder.v}
vlog -vlog01compat -work work +incdir+C:/Users/nawaz/OneDrive/Desktop/programing/verilog/eyantra\ task\ 1/t1c_riscv_cpu/risc-V/code {C:/Users/nawaz/OneDrive/Desktop/programing/verilog/eyantra task 1/t1c_riscv_cpu/risc-V/code/instr_mem.v}

vlog -vlog01compat -work work +incdir+C:/Users/nawaz/OneDrive/Desktop/programing/verilog/eyantra\ task\ 1/t1c_riscv_cpu/risc-V/.test {C:/Users/nawaz/OneDrive/Desktop/programing/verilog/eyantra task 1/t1c_riscv_cpu/risc-V/.test/tb.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  tb

add wave *
view structure
view signals
run 1 ms
