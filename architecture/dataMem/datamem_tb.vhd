library ieee;
use ieee.std_logic_1164.all;
--use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity test_data is 
end test_data;


architecture bench of test_data is
	component data_test is
	port(
		adresse : in std_logic_vector(7 downto 0);
		input : in std_logic_vector(7 downto 0);
		rw : in std_logic;
		rst : in std_logic;
		clk : in std_logic;
		output : out std_logic_vector(7 downto 0)
	
	);
	end component;

for all : data_test use entity work.data_memory(behavorial);

signal ad : std_logic_vector(7 downto 0);
signal input,output : std_logic_vector(7 downto 0);
signal rw,rst,clk : std_logic;

constant half_period : time := 5 ns;

begin
	test : data_test port map (ad,input,rw,rst,clk,output);
	rst <= '0','1' after 11 ns;
	ad <= "00000001";
	rw <= '0', '1' after 27 ns; 
	input <= "10111011"; 	
	clk <= '1', '0' after half_period, '1' after 2*half_period,'0' after 3*half_period,'1' after 4*half_period,'0' after 5*half_period,'1' 		after 6*half_period,'0' after 7*half_period;
	


end bench;
