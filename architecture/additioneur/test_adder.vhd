
entity test_adder is
end test_adder;
architecture bench of test_adder is
	component adder is 
		port (i0, i1 : in bit; ci : in bit; s : out bit; co : out bit);
	end component;

for all : adder use entity work.adder(rtl);

signal data1,data2,data3 : bit;
signal dataout,carry_out : bit;

begin
	additioneur:adder port map (data1,data2,data3,dataout,carry_out);
	data1<='0','1' after 30 ns;
	data2<='1','0' after 50 ns,'1' after 60 ns;
	data3<='0','1' after 12 ns;

end bench;
