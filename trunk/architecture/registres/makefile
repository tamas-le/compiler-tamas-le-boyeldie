compiler: *.vhd
	ghdl -a --std=02 --ieee=mentor reg.vhd
	ghdl -a --std=02 --ieee=mentor reg_tb.vhd
	ghdl -e --std=02 --ieee=mentor test_reg
	ghdl -r test_reg --vcd=reg.vcd
	
trace: *.vcd
	gtkwave reg.vcd
