compiler: *.vhd
	ghdl -a --std=02 --ieee=mentor ual.vhd
	ghdl -a --std=02 --ieee=mentor ual_tb.vhd
	ghdl -e --std=02 --ieee=mentor test_ual
	ghdl -r test_ual --vcd=ual.vcd
	
trace: *.vcd
	gtkwave ual.vcd
