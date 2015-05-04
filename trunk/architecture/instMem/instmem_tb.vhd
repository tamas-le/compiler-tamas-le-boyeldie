library ieee;
use ieee.std_logic_1164.all;
--use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity test_inst is 
end test_inst;


architecture bench of test_inst is
	component inst_test is
	port(
		adresse : in std_logic_vector(7 downto 0);
		clk : in std_logic;
		output : out std_logic_vector(31 downto 0)
	
	);
	end component;

for all : inst_test use entity work.inst_memory(behavorial);

signal ad : std_logic_vector(7 downto 0);
signal output : std_logic_vector(31 downto 0);
signal clk : std_logic;

constant half_period : time := 5 ns;

begin
	test : inst_test port map (ad,clk,output);
	ad <= "00000001";
	clk <= '1', '0' after half_period, '1' after 2*half_period,'0' after 3*half_period,'1' after 4*half_period,'0' after 5*half_period,'1' 		after 6*half_period,'0' after 7*half_period;
	
end bench;
