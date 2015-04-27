library ieee;
use ieee.std_logic_1164.all;
--use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity test_ual is
end test_ual;
architecture bench of test_ual is
	component ual is 
		port(a, b : in std_logic_vector(7 downto 0);	
		op : in std_logic_vector(2 downto 0);
		zero,carry,negative,overflow : out std_logic;
	    	f : out std_logic_vector(7 downto 0));
	end component;

for all : ual use entity work.alu8bit(behavioral);

--signal data1,data2,data3 : bit;
--signal dataout,carry_out : bit;

signal n : std_logic;
signal o : std_logic;
signal c : std_logic;
signal z : std_logic;
signal a : std_logic_vector(7 downto 0);
signal b : std_logic_vector(7 downto 0);
signal ou : std_logic_vector(7 downto 0);
signal ope:std_logic_vector(2 downto 0);

begin
	--additioneur:adder port map (data1,data2,data3,dataout,carry_out);
	test : ual port map(a,b,ope,z,c,n,o,ou);
	ope<="000","101" after 10 ns,"010" after 15 ns;
	a<="00000011","00001000" after 20 ns;
	b<="00000100","00000010" after 20 ns;
	
	--data1<='0','1' after 30 ns;
	--data2<='1','0' after 50 ns,'1' after 60 ns;
	--data3<='0','1' after 12 ns;

end bench;
